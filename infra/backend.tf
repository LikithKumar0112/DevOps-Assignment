terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "pgagi-terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "pgagi-terraform-locks"
    encrypt        = true
  }
}

