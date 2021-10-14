# Infrastructure On Demand - AWS
This is a simple proof of concept ChatOps Bot that can create/destroy infrastructure based on the Terraform plans in the various branches of the repository.  To manage the AWS infrastructure defined in this branch add a comment to the issue with the label **branch/aws-test**.

## The Plan

The Terraform plan in this branch is intended to launch EC2 instances with the proper policies in place so Cloudman can manage an AWS cluster.

### Commands

```
/validate
/plan
/apply
/destroy
/test
```

All of the commands, except the /`test` command, run the equivalent terraform command, ie. `/plan` runs `terraform plan`.  The `/test` command is provided as a hook for testing and development purposes.

## Terraform State

Terraform stores state information about the infrastructure is is managing on the local filesystem.  This is fine for local development, but in a CI system these files need to be stored somewhere persistent.  In this case we configure a S3 *backend* to store files in a S3 bucket and lock files in a DynamoDB.



