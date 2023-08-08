terraform {
  backend "s3" {
    bucket = "terraform-backend-raya"
    key    = "terraform/jenkins.tfstate"
    region = "us-east-1"

  }
}