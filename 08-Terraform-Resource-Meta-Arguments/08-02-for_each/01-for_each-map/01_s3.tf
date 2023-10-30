# Create S3 Bucket per environment with for_each and maps
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "mys3bucket" {
  for_each = {
    dev = "venkat-app-log"
    uat = "venkat-app-log"
    pre = "venkat-app-log"
    prd = "venkat-app-log"
  }
  bucket = "${each.key}-${each.value}"

  tags = {
    Name = "${each.key}-${each.value}"
    Env  = each.key
  }
}


