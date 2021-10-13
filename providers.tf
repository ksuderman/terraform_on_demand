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

  # Uncomment this after the S3 bucket has been bootstrapped.
  # backend "s3" {
  #   bucket         = var.s3_bucket
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = var.lock_table
  #   encrypt        = true
  # }

}

provider "openstack" {}

provider "aws" {
  region  = "us-east-1"
}

module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = var.s3_bucket #"ks-github-tfstate"
  dynamo_db_table_name        = var.lock_table #"aws-locks"
  iam_user_name               = "KeithsTerraformGitHubBot"
  ado_iam_role_name           = "IamRole"
  aws_iam_policy_permits_name = "IamPolicyPermits"
  aws_iam_policy_assume_name  = "IamPolicyAssume"
}
