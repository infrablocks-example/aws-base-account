module "admin" {
  source  = "infrablocks/admin/aws"
  version = "1.0.0"

  admin_public_gpg_key = filebase64(var.admin_public_gpg_key_path)
  admin_user_password_length = var.minimum_password_length
}
