resource "aws_iam_user" "iam_user" {
  name = "${local.namespace}-user"
}

resource "aws_iam_access_key" "iam_user_key" {
  user = aws_iam_user.iam_user.name
}

resource "aws_iam_user_policy" "media_access_policy" {
  name   = "s3-media-access-policy"
  user   = aws_iam_user.iam_user.name
  policy = data.aws_iam_policy_document.bucket_acccess.json
}

resource "aws_ses_identity_policy" "email_send_policy" {
  count = local.ses_count

  identity = data.aws_ses_domain_identity.main[count.index].arn
  name     = "email-send-policy"
  policy   = data.aws_iam_policy_document.ses_email_send.json
}
