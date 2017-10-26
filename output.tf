output "role_arn" {
    value = "${aws_iam_role.saml_role.arn}"
}

output "github_team_id" {
    value = "${github_team.saml_role_github_team.id}"
}