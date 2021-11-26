 module "cross_account_admin_role" {
  source  = "infrablocks/cross-account-role/aws"
  version = "1.0.0"

  role_name = "cross-account-admin-role"
  assumable_by_account_ids = var.admin_assumable_by_account_ids
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "cross_account_read_only_role" {
  source  = "infrablocks/cross-account-role/aws"
  version = "1.0.0"

  role_name = "cross-account-read-only-role"
  assumable_by_account_ids = var.read_only_assumable_by_account_ids
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
