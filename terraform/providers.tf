terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

locals {
  ssh_user         = "ubuntu"
  key_name         = "plesk_key_pair"
  private_key_path = "/home/ubuntu/environment/plesk_key_pair.pem"
}