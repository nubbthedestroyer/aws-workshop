module "account02" {
  source = "modules/users-in-account"
  access_key = "${var.access_key_02}"
  secret_key = "${var.secret_key_02}"

  number_of_users = 5

  keybase_user = "${var.keybase_user}"
}

variable "access_key_02" {}
variable "secret_key_02" {}
variable "account_02" {}

output "account02-user0" {
  value = "\nlogin_url = https://${var.account_02}.signin.aws.amazon.com/console\nusername = ${module.account02.username_for_user_0}\npassword_cmd = echo \"${module.account02.password_for_user_0}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account02-user1" {
  value = "\nlogin_url = https://${var.account_02}.signin.aws.amazon.com/console\nusername = ${module.account02.username_for_user_1}\npassword_cmd = echo \"${module.account02.password_for_user_1}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account02-user2" {
  value = "\nlogin_url = https://${var.account_02}.signin.aws.amazon.com/console\nusername = ${module.account02.username_for_user_2}\npassword_cmd = echo \"${module.account02.password_for_user_2}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account02-user3" {
  value = "\nlogin_url = https://${var.account_02}.signin.aws.amazon.com/console\nusername = ${module.account02.username_for_user_3}\npassword_cmd = echo \"${module.account02.password_for_user_3}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}

output "account02-user4" {
  value = "\nlogin_url = https://${var.account_02}.signin.aws.amazon.com/console\nusername = ${module.account02.username_for_user_4}\npassword_cmd = echo \"${module.account02.password_for_user_4}\" | sed -e 's/\\[//g' -e 's/\\]//g' | base64 --decode | keybase pgp decrypt"
}