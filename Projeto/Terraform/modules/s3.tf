resource "aws_s3_bucket" "bucket_devopschallenge" {
  bucket = "devops_challenge-${var.ambiente}"

  tags = {
    Name        = "Bucket-S3-${var.ambiente}"
    Environment = var.ambiente
  }
}