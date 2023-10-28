# Create 3 IAM Users using single resource block
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "iamuser" {
    for_each = toset(["Venkat", "Suresh", "Ramesh", "Venkat"])
    name = each.key

    tags = {
      Name = each.key
    }
}

# above can also be written using map

# resource "aws_iam_user" "iamuser" {
#   for_each = {
#     Venkat  = null
#     Suresh  = null
#     Ramesh  = null
#   }

#   name = each.key

#   tags = {
#     Name = each.key
#   }
# }

