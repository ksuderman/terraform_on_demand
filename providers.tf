terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  # Uncomment this after the S3 bucket has been bootstrapped.
  backend "s3" {
    bucket         = "ks-github-tf-aws"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ks-github-tf-aws"
    encrypt        = true
  }

}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


provider "openstack" {}

module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = var.s3_bucket #"ks-github-tfstate"
  dynamo_db_table_name        = var.lock_table #"aws-locks"
  # iam_user_name               = "KeithsTerraformGitHubBot"
  # ado_iam_role_name           = "IamRole"
  # aws_iam_policy_permits_name = "IamPolicyPermits"
  # aws_iam_policy_assume_name  = "IamPolicyAssume"
}
