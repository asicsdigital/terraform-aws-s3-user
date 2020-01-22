locals {
  bucket_arn    = "arn:aws:s3:::${var.bucket_name}"
  object_arn    = "arn:aws:s3:::${var.bucket_name}/${var.prefix}*"
  write_access  = var.write_access ? "_write" : ""
  delete_access = var.delete_access ? "_delete" : ""
  policy        = var.write_access ? var.delete_access ? data.aws_iam_policy_document.user_policy_read_write_delete.json : data.aws_iam_policy_document.user_policy_read_write.json : data.aws_iam_policy_document.user_policy_read.json
}

