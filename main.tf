data "aws_caller_identity" "current" {}
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.document.json
  #permissions_boundary = var.permisssions_boundary_arn
  tags = var.tags
}

data "aws_iam_policy_document" "document" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = var.iam_policy_identifiers #["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}


resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = length(var.managed_policy_arns) > 0 ? var.managed_policy_arns : []
  role       = join("", aws_iam_role.this.*.name)
  policy_arn = each.key
}

data "aws_iam_policy_document" "override" {
  count                     = var.add_custom_policy ? 1 : 0
  override_policy_documents = var.custom_policy_statements
}

resource "aws_iam_policy" "default" {
  count  = var.add_custom_policy ? 1 : 0
  name   = var.custom_policy_name
  policy = join("", data.aws_iam_policy_document.override[0].*.json)
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.add_custom_policy ? 1 : 0
  role       = join("", aws_iam_role.this.*.name)
  policy_arn = join("", aws_iam_policy.default[0].*.arn)
}

resource "aws_iam_instance_profile" "default" {
  count = var.is_instance_profile_enabled ? 1 : 0
  name  = var.instance_profile_name
  role  = join("", aws_iam_role.this.*.name)
}