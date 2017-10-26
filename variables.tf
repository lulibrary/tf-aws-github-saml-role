variable "aws_provider_profile" {
    description = "AWS profile to use for the AWS provider"
    default = "default"
}

variable "aws_provider_region" {
    description = "AWS region to use for the AWS provider"
}

variable "aws_provider_assume_role_arn" {
    description = "ARN of role to assume for the AWS provider"
    default = ""
}

variable "aws_saml_provider_arn" {
    description = "ARN of the IAM SAML Provider"
}

variable "aws_saml_provider_assume_policy_sid" {
    description = "SID to give the assume role policy for the SAML role"
}

variable "aws_saml_role_name" {
    description = "Name of the role/team to create"
}

variable "github_team_privacy" {
    description = "Privacy of the created GitHub team, can be secret or closed."
    default = "secret"
}

variable "aws_role_allowed_github_maintainer_users" {
    type = "list"
    description = "List of the github users allowed to maintain this team on github"
    default = []
}

variable "aws_role_allowed_github_users" {
    type = "list"
    description = "List of the users allowed to assume this role"
    default = []
}