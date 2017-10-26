output "role_arn" {
    value = "${aws_iam_role.saml_role.arn}"
    description  = "ARN of the AWS role created for the SAML provider"
}

output "github_team_id" {
    value = "${github_team.saml_role_github_team.id}"
    description = "ID of the GitHub team created to control access to this AWS role"
}