output "s3_website_endpoint" {
  value = "http://${aws_s3_bucket.mybucket.website_endpoint}/"

}

# output "s3_website_domain" {
#   value = "http://${aws_s3_bucket.mybucket.website_domain}/"
# }

