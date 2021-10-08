# Infrastructure On Demand
This is a simple proof of concept using GitHub actions to create infrastructure on OpenStack (Jetstream) using Terraform. The following actions are used:

1. push to the `dev` branch: runs `terraform validate` and `terraform plan` on the dev branch.
2. open a PR: runs `terraform apply`
3. close the PR: runs `terraform destroy`

The terraform state is stored in an S3 bucket.

## Future Work

### Multiple Clusters

Since the terraform state is store in a single S3 bucket only a single cluster can be managed.  Use [something to bootstrap](https://github.com/KyMidd/Terraform_CI-CD_Bootstrap) the creation of the the DynamoDB table so the state from multiple clusters can be stored without stomping all over one another.

Cluster configurations could be stored in separate branches with some logic to determined when to run `terraform validate|plan|apply|destroy`. Possibilities include:

1. When a PR is opened/closed
2. When an issue is opened/closed
3. Based on keywords in [issue comments](https://pakstech.com/blog/gh-actions-issue-comments/)
4. Some other criteria

