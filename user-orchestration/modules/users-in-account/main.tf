provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_iam_user" "workshop_user_" {
  count = "${var.number_of_users}"
  name = "${var.userprefix}_workshop_user_${count.index}"
  force_destroy = true
}

resource "aws_iam_access_key" "workshop_user_keys_" {
  count = "${var.number_of_users}"
  user = "${aws_iam_user.workshop_user_.*.name[count.index]}"
}

resource "aws_iam_user_policy" "workshop_user_pol_" {
  count = "${var.number_of_users}"
  name = "${var.userprefix}_workshop_user_pol_${count.index}"
  user = "${aws_iam_user.workshop_user_.*.name[count.index]}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_login_profile" "workshop_user_profile" {
  count = "${var.number_of_users}"
  pgp_key = "${var.keybase_user}"
  user = "${aws_iam_user.workshop_user_.*.name[count.index]}"
  depends_on = ["aws_iam_user.workshop_user_"]
  password_reset_required = false
  password_length = 5
}