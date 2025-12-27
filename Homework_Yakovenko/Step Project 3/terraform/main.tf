provider "aws" {
  region = var.region
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "yakovenko-jenkins-main-626126209976"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC840uOV3mhgebSfx4VgQ4iyUtuGwbMICaCV1IHBRfb/Kp6KmsieuQTIV38bUrEsLv0oqc8dkaKE5E2baKD9nf+sx7GSLSU/NHgqWYxgiTT0yXc9NdDUbFWjSE6M96tVvgx8t+cEPp/y9Gv/TXD83JENHildzhrMMy5Epkgpauuywe/uA/OEkaBWGSsR1X+Ke4enAoygl0MGaPSBJlQpotLsDKLl0H0sVLQo3TL1ecReC4tDBro08mBV/lemfGrFjv5M7rrBuSwy9E3fRfKpJmBxeMylwbfTHPCFmKP8hRYpPnyD0aR6F9O848vUhAXzltYUMBJmsn19PFYlcC9q4M+WsBTNe9pHFxtf7+SLVgKJttaDeBKFZNrhhKC6+Y+Bf3OR+fD9mDu0zbNa53nCnFec/TDYtxOvaT9tSLecah5Coz16wkHvUk3mtkTmW2tpKl6OVnTxeX0C7GpxnxUoNPQM/hAqyyp+zaRMA0VT38E6dxWWtWrBKG8Al9jE/p9SkxOzVGzIyrYYqkExnYiyiIgBPd+GUTaZgKS6zfWDxPmjTeCZIzU6TMpmLJ2YXBsX/ThwIJve6HJHvoSHJydKg1bj2bRaproMvXWdaUKTMA/93LjfcizFW0pFgL+02UL+FyBDzS37pm8fuEBBe5BHlpuLFF52/Ug1FFmVlzNL/pkBw== yakovenko-jenkins-main"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "main-vpc" }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags                    = { Name = "public-subnet" }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags       = { Name = "private-subnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "main-igw" }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.nat_eip.id
  tags          = { Name = "nat-gateway" }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "private-rt" }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "jenkins_sg" {
  name   = "jenkins-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "jenkins-sg" }
}

resource "aws_instance" "jenkins_master" {
  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = file("user_data_master.sh")

  tags = { Name = "jenkins-master" }
}

resource "aws_instance" "jenkins_worker" {
  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  instance_market_options {
    market_type = "spot"

    spot_options {
      spot_instance_type = "one-time"
    }
  }

  tags = { Name = "jenkins-worker-spot" }
}

output "jenkins_master_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "jenkins_worker_private_ip" {
  value = aws_instance.jenkins_worker.private_ip
}
