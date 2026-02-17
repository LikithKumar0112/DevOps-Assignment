terraform {
  backend "s3" {
    bucket         = "pgagi-terraform-state-bucket"
    key            = "staging/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "pgagi-terraform-locks"
    encrypt        = true
  }
}

