data "aws_iam_policy_document" "user_policy_read" {
  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "${local.bucket_arn}",
    ]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "s3:prefix"

      values = [
        "${var.prefix}*",
      ]
    }
  }
}

data "aws_iam_policy_document" "user_policy_read_write" {
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

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "s3:prefix"

      values = [
        "${var.prefix}*",
      ]
    }
  }
}

data "aws_iam_policy_document" "user_policy_read_write_delete" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
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

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "s3:prefix"

      values = [
        "${var.prefix}*",
      ]
    }
  }
}

resource "aws_iam_policy" "user_policy" {
  name_prefix = "${var.user_name}-"
  policy      = "${local.policy}"
}

resource "aws_iam_user" "user" {
  name          = "${var.user_name}"
  force_destroy = "${var.force_destroy}"
}

resource "aws_iam_user_policy_attachment" "user_policy" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${aws_iam_policy.user_policy.arn}"
}

resource "aws_iam_access_key" "key" {
  user     = "${aws_iam_user.user.name}"
}
