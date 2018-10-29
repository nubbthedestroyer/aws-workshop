module "account01" {
  source = "modules/users-in-account"
  access_key = "${var.access_key_01}"
  secret_key = "${var.secret_key_01}"

  number_of_users = 5

  keybase_user = "${var.keybase_user}"
}

variable "access_key_01" {}
variable "secret_key_01" {}
variable "account_01" {}

output "account01-user0" {
  value = "\nlogin_url = https://${var.account_01}.signin.aws.amazon.com/console\nusername = ${module.account01.username_for_user_0}\npassword_cmd = echo \"${module.account01.password_for_user_0}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account01-user1" {
  value = "\nlogin_url = https://${var.account_01}.signin.aws.amazon.com/console\nusername = ${module.account01.username_for_user_1}\npassword_cmd = echo \"${module.account01.password_for_user_1}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account01-user2" {
  value = "\nlogin_url = https://${var.account_01}.signin.aws.amazon.com/console\nusername = ${module.account01.username_for_user_2}\npassword_cmd = echo \"${module.account01.password_for_user_2}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account01-user3" {
  value = "\nlogin_url = https://${var.account_01}.signin.aws.amazon.com/console\nusername = ${module.account01.username_for_user_3}\npassword_cmd = echo \"${module.account01.password_for_user_3}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account01-user4" {
  value = "\nlogin_url = https://${var.account_01}.signin.aws.amazon.com/console\nusername = ${module.account01.username_for_user_4}\npassword_cmd = echo \"${module.account01.password_for_user_4}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}