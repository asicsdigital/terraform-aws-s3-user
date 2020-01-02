locals {
  "bucket_arn"               = "arn:aws:s3:::${var.bucket_name}"
  "object_arn"               = "arn:aws:s3:::${var.bucket_name}/${var.prefix}*"
}
