variable "vpc_id" {
  description = "ID of the VPC where EC2 will be created"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of ports to open in the security group"
  type        = list(number)
  default     = [80]
}
