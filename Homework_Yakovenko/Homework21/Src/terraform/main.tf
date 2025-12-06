provider "aws" {
  region = "eu-central-1"
}

# Get latest Amazon Linux 2023 AMI automatically
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_key_pair" "deployer" {
  key_name   = "yakovenko_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "nginx" {
  count         = 2
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  tags = {
    Name = "nginx-${count.index + 1}"
  }
}

resource "local_file" "inventory" {
  filename = "../ansible/inventory.ini"
  content  = <<EOF
[nginx]
${aws_instance.nginx[0].public_ip}
${aws_instance.nginx[1].public_ip}

[nginx:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF
}

output "public_ips" {
  value = aws_instance.nginx[*].public_ip
}
