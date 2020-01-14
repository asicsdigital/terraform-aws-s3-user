locals {
  "bucket_arn"               = "arn:aws:s3:::${var.bucket_name}"
  "object_arn"               = "arn:aws:s3:::${var.bucket_name}/${var.prefix}*"
  write_access               = "${var.write_access ? "_write" : ""}"
  delete_access              = "${var.delete_access ? "_delete" : ""}"
  policy                    = "${data.aws_iam_policy_document.user_policy_read${local.write_access}${local.delete_access}.json}"
}
