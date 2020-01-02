variable "bucket_name" {
  type        = "string"
  description = "Name for s3 bucket"
}

variable "prefix" {
  type        = "string"
  description = "Prefix to grant access to, note this module does not add any trailing /"
}

variable "user_name" {
  type        = "string"
  description = "Short name for the IAM user to create"
}

variable "force_destroy" {
  default     = true
  description = "Force_destroy the IAM user created by this module? (Default true)"
}
