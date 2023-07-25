terraform {
  backend "s3" {
    bucket = "backend-terraform-state-2023-gulnaz-new"
    key    = "terraform/jenkins.tfstate"
    region = "us-east-1"

  }
}