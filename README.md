# Infrastructure On Demand
This is a simple proof of concept ChatOps Bot that can create/destroy infrastructure based on the Terraform plans in the `testing` branch of this repository.  In the future the branch to use will be specified as a parameter to the chat command or as a label, and each branch will contain a separate Terraform plan for the infrastructure to manage

Add a comment to issue #2 with one of the recognized commands on the first line.  Subsequent lines are ignored and can be used for documentation.

### Commands

```
/validate
/plan
/apply
/destroy
/test
```

All of the commands, except the /`test` command, run the equivalent terraform command, ie. `/plan` runs `terraform plan`.  The `/test` command is provided as a hook for testing and development purposes.

## Future Work

1. **Terraform State**: Since the terraform state is stored in a single S3 bucket only a single cluster can be managed.  Use something [like this](https://github.com/KyMidd/Terraform_CI-CD_Bootstrap) to bootstrap the creation of the the DynamoDB table so the state from multiple clusters can be stored without stomping all over each another.
2. **Parameterize branch**: The branch to checkout should be specified as a parameter to the chat command or as an issue label.  Prefer the label to avoid dealing with typos and unwanted behavior relying on the user to specify a valid branch
3. **Pass variables** from the chat command to the Terraform plan.



