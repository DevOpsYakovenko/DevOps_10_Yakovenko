provider "aws" {
  region = "eu-central-1"
}

module "nginx_server" {
  source             = "./modules/ec2_nginx"
  vpc_id             = var.vpc_id
  list_of_open_ports = var.list_of_open_ports
}
