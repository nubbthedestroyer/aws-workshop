output "access_key_for_user_0" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.id[0]}"
}

output "secret_key_for_user_0" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.secret[0]}"
}

output "username_for_user_0" {
  value = "${aws_iam_user.workshop_user_.*.name[0]}"
}

output "password_for_user_0" {
  value = "[${aws_iam_user_login_profile.workshop_user_profile.*.encrypted_password[0]}]"
}

output "access_key_for_user_1" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.id[1]}"
}

output "secret_key_for_user_1" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.secret[1]}"
}

output "username_for_user_1" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.user[1]}"
}

output "password_for_user_1" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.encrypted_password[1]}"
}

output "access_key_for_user_2" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.id[2]}"
}

output "secret_key_for_user_2" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.secret[2]}"
}

output "username_for_user_2" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.user[2]}"
}

output "password_for_user_2" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.encrypted_password[2]}"
}

output "access_key_for_user_3" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.id[3]}"
}

output "secret_key_for_user_3" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.secret[3]}"
}

output "username_for_user_3" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.user[3]}"
}

output "password_for_user_3" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.encrypted_password[3]}"
}

output "access_key_for_user_4" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.id[4]}"
}

output "secret_key_for_user_4" {
  value = "${aws_iam_access_key.workshop_user_keys_.*.secret[4]}"
}

output "username_for_user_4" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.user[4]}"
}

output "password_for_user_4" {
  value = "${aws_iam_user_login_profile.workshop_user_profile.*.encrypted_password[4]}"
}

