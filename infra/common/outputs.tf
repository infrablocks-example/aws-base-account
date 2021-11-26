data "aws_caller_identity" "current" {}

output "admin_details" {
  value = {
    access_key_id = module.admin.admin_user_access_key_id
    arn = module.admin.admin_user_arn
    name = module.admin.admin_user_name
    password = module.admin.admin_user_password
    secret_access_key = module.admin.admin_user_secret_access_key
    sign_in_url = "https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console"
  }
}

output "admin_role_arn" {
  value = module.cross_account_admin_role.role_arn
}

output "read_only_role_arn" {
  value = module.cross_account_read_only_role.role_arn
}
