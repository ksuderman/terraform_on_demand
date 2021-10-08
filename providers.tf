terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
    aws = {
      version = "~> 2.36.0"
    }
  }

  backend "s3" {
    bucket         = "ks-terraform-github-actions"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ks-terraform-github-state"
    encrypt        = true
  }

}

provider "openstack" {}

provider "aws" {
  region  = "us-east-1"
}
