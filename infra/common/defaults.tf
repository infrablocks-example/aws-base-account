module "account-defaults" {
  source  = "infrablocks/account-defaults/aws"
  version = "1.0.0"

  account_alias = var.account_alias
  minimum_password_length = var.minimum_password_length
}
