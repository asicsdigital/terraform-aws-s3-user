variable "bucket_name" {
  type        = string
  description = "Name for s3 bucket"
}

variable "prefix" {
  type        = string
  description = "Prefix to grant access to, note this module does not add any trailing /"
}

variable "user_name" {
  type        = string
  description = "Short name for the IAM user to create"
}

variable "create_user" {
  default     = true
  description = "True if a user needs to be created.  False if the user already exists."
}

variable "force_destroy" {
  default     = true
  description = "Force_destroy the IAM user created by this module? (Default true)"
}

variable "write_access" {
  default     = true
  description = "Generated policy will have S3:PutObject permission"
}

variable "delete_access" {
  default     = false
  description = "Generated policy will have S3:DeleteObject permission"
}
