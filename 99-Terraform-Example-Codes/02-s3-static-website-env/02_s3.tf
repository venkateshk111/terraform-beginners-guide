# Step 1: Create a bucket
resource "aws_s3_bucket" "mybucket" {
  bucket        = format("%s-%s", var.bucket_name, var.env)
  force_destroy = true
}

# Step 2: Enable static website hosting
resource "aws_s3_bucket_website_configuration" "mybucket_website" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Step 3: Edit Block Public Access settings
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Step 4: Add a bucket policy that makes your bucket content publicly available
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.mybucket.arn}/*"
      }
    ]
  })
}

# Step 5: Configure an index document
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mybucket.bucket
  key          = "index.html"
  source       = "website-files/index.html"
  content_type = "text/html"
}

#Step 6: Configure an error document
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.mybucket.bucket
  key          = "error.html"
  source       = "website-files/error.html"
  content_type = "text/html"
}
