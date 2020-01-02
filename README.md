# terraform-aws-s3-user
Terraform module for creating an IAM user with access to write into a specific s3 prefix

----------------------

#### Required

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_name | Name for s3 bucket | string | n/a | yes |
| prefix | Prefix to grant access to, note this module does not add any trailing / | string | n/a | yes |
| user\_name | Short name for the IAM user to create | string | n/a | yes |

#### Optional

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| force\_destroy | Force\_destroy the IAM user created by this module? \(Default true\) | string | `"true"` | no |


Outputs
=======

- `iam_user_access_key_id`
- `iam_user_secret_access_key` (sensitive, use `terraform outputs` to view)

Authors
=======

* [John Noss](https://github.com/jnoss)


Changelog
=========

1.0.0 - Initial release.

License
=======

This software is released under the MIT License (see `LICENSE`).
