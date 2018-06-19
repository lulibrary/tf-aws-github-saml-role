provider "aws" {
  alias   = "module"
  profile = "${var.aws_provider_profile}"
  region  = "${var.aws_provider_region}"

  assume_role {
    role_arn = "${var.aws_provider_assume_role_arn}"
  }
}

data "aws_iam_policy_document" "saml_assume_role_policy" {
  provider = "aws.module"

  statement {
    sid = "${var.aws_saml_provider_assume_policy_sid}"

    actions = [
      "sts:AssumeRoleWithSAML",
    ]

    principals {
      type = "Federated"

      identifiers = [
        "${var.aws_saml_provider_arn}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "saml:aud"

      values = [
        "https://signin.aws.amazon.com/saml",
      ]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "saml:edupersonorgunitdn"

      values = [
        "${var.aws_saml_role_name}",
      ]
    }
  }
}

resource "aws_iam_role" "saml_role" {
  provider           = "aws.module"
  name               = "${var.aws_saml_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.saml_assume_role_policy.json}"
}

resource "github_team" "saml_role_github_team" {
  name           = "${var.aws_saml_role_name}"
  description    = "${aws_iam_role.saml_role.arn},${var.aws_saml_provider_arn}"
  privacy        = "${var.github_team_privacy}"
  parent_team_id = "${var.github_team_parent_id}"
}

resource "github_team_membership" "saml_role_team_maintainers" {
  count    = "${length(var.aws_role_allowed_github_maintainer_users)}"
  team_id  = "${github_team.saml_role_github_team.id}"
  username = "${element(var.aws_role_allowed_github_maintainer_users, count.index)}"
  role     = "maintainer"
}

resource "github_team_membership" "saml_role_team_members" {
  count    = "${length(var.aws_role_allowed_github_users)}"
  team_id  = "${github_team.saml_role_github_team.id}"
  username = "${element(var.aws_role_allowed_github_users, count.index)}"
  role     = "member"
}
