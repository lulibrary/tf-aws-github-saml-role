# TF - AWS GitHub SAML Role
Terraform module for defining an AWS role for use with a SAML IdP with access controlled by GitHub teams membership.

## Using the module

```[hcl]
module "operations_admin_role" {
    source = "github.com/lulibrary/tf-aws-github-saml-role"

    aws_provider_profile = "myproviderprofile"
    aws_provider_region = "$eu-west-1"
    aws_provider_assume_role_arn = "arn:aws:iam::111111111111:role/OrganizationAccountAccessRole"

    aws_saml_provider_arn = "mysamlproviderarn"
    aws_saml_provider_assume_policy_sid = "ShibbolethOpsAdmin"
    aws_saml_role_name = "Operations-Admin"
    github_team_privacy = "closed"
    aws_role_allowed_github_maintainer_users = ["myMaintainerUserName"]
    aws_role_allowed_github_users = ["myMemberUserName"]
}
```

## Input Variables

| Variable | Default | Description |
| --- | --- | --- |
| aws_provider_profile | default | Profile to use from the aws credentials file |
| aws_provider_region | N/A | Region to initialise the provider in |
| aws_provider_assume_role_arn | `Empty String` | ARN of the role to assume for the specified provider |
| aws_saml_provider_arn | N/A | ARN of the IAM SAML Provider to link this role to |
| aws_saml_provider_assume_policy_sid | N/A | SID to give the assume role policy for the SAML role |
| aws_saml_role_name | N/A | Name of the role/team to create |
| github_team_privacy | secret | Privacy of the created GitHub team, can be secret or closed |
| github_team_parent_id | N/A | Team ID for the parent team of the team being created. |
| aws_role_allowed_github_maintainer_users | [] | List of the github users allowed to maintain this team on github and assume the role |
| aws_role_allowed_github_users | [] | List of the github users allowed to assume this role |

## Output Variables

| Variable | Description |
| --- | --- |
| role_arn | ARN of the AWS role created for the SAML provider |
| github_team_id | ID of the GitHub team created to control access to this AWS role |