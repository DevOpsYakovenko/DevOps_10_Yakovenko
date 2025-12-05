variable "list_of_open_ports" {
  type    = list(number)
  default = [80, 22]
}

variable "ami" {
  type    = string
  default = "ami-0f7204385566b32d0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for EC2 instance"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for security group"
}

variable "instance_name" {
  type    = string
  default = "nginx-instance"
}
