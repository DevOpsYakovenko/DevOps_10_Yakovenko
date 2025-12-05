module "nginx_server" {
  source = "./modules/ec2_nginx"

  ami           = "ami-0f7204385566b32d0"
  instance_type = "t2.micro"

  subnet_id = var.subnet_id
  vpc_id    = var.vpc_id

  instance_name = "nginx-instance"
}
