resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

resource "aws_s3_bucket" "media" {
  bucket = "${local.namespace}-media-${random_string.bucket_suffix.result}"
}

resource "aws_s3_bucket_acl" "media_acl" {
  bucket = aws_s3_bucket.media.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "media_public_access_block" {
  bucket = aws_s3_bucket.media.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.media.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
