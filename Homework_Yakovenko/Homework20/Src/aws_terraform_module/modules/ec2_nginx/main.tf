resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow inbound ports from input"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.list_of_open_ports
    content {
      description = "Open port"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami                         = "ami-0ec7f9846da6b0f61" # Amazon Linux 2023 - eu-central-1
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name = "nginx-instance"
  }
}
