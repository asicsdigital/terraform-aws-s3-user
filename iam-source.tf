data "aws_iam_policy_document" "user_policy" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${local.object_arn}",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "${local.bucket_arn}",
    ]
  }
}

resource "aws_iam_policy" "user_policy" {
  provider   = "aws.source"
  name_prefix = "${var.user_name}-"
  policy      = "${data.aws_iam_policy_document.user_policy.json}"
}

resource "aws_iam_user" "user" {
  provider   = "aws.source"
  name          = "${var.user_name}"
  force_destroy = "${var.force_destroy}"
}

resource "aws_iam_user_policy_attachment" "user_policy" {
  provider   = "aws.source"
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${aws_iam_policy.user_policy.arn}"
}

resource "aws_iam_access_key" "key" {
  provider   = "aws.source"
  user     = "${aws_iam_user.user.name}"
}
