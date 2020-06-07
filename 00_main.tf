provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket               = "htc-kiddie-tfstate"
    workspace_key_prefix = "kiddie"
    key                  = "kiddie.tfstate"
    region               = "eu-west-1"
    encrypt              = true
  }
}
