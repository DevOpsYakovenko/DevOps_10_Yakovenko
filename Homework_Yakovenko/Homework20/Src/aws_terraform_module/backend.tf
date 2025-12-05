terraform {
  backend "s3" {
    bucket = "terraform-state-danit10-devops"
    key    = "KristinaYakovneko/terraform.tfstate"
    region = "eu-central-1"
  }
}
