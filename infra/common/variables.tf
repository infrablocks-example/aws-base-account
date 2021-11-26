variable "region" {}

variable "account_alias" {}
variable "minimum_password_length" {}

variable "admin_public_gpg_key_path" {}

variable "admin_assumable_by_account_ids" {
  type = list(string)
}
variable "read_only_assumable_by_account_ids" {
  type = list(string)
}
