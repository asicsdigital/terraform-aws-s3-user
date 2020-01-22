data "aws_iam_user" "user" {
  count     = var.create_user ? 0 : 1
  user_name = var.user_name
}

resource "aws_iam_policy" "user_policy" {
  name_prefix = "${var.user_name}-"
  policy      = local.policy
}

resource "aws_iam_user" "user" {
  count         = var.create_user ? 1 : 0
  name          = var.user_name
  force_destroy = var.force_destroy
}

resource "aws_iam_user_policy_attachment" "user_policy" {
  user       = aws_iam_user.user[0].name
  policy_arn = aws_iam_policy.user_policy.arn
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user[0].name
}

data "aws_iam_policy_document" "user_policy_read" {
  statement {
    actions = [
      "s3:ListBucket",
    ]

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [
      local.bucket_arn,
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

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [
      local.object_arn,
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [
      local.bucket_arn,
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
      "s3:DeleteObject",
    ]

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [
      local.object_arn,
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [
      local.bucket_arn,
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

