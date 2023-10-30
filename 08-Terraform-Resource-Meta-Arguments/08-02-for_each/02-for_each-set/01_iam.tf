# Create 3 IAM Users using single resource block
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "iamuser" {
  for_each = toset(["Amar", "Akbar", "Anthony", "Amar"]) # Though user Amar is defined twice, set would remove duplicate
  name     = each.key

  tags = {
    Name = each.key
    # Name = each.value # when using set , each.key == each.value , so you can use either key or value.
  }
}

# above can also be written using map

# resource "aws_iam_user" "iamuser" {
#   for_each = {
#     Amar  = null
#     Akbar  = null
#     Anthony  = null
#   }

#   name = each.key

#   tags = {
#     Name = each.key
#   }
# }

