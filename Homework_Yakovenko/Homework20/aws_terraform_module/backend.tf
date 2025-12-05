terraform {
  backend "s3" {
    bucket = "terraform-state-danit-devops"
    key    = "DevOpsYakovneko/terraform.tfstate"
    region = "eu-central-1"
  }
}
