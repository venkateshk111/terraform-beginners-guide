# Terraform Import

## Bringing your Existing Infrastructure Under IaC

- **terraform import** command used to **import existing infrastructure into your Terraform state**.
- **terraform import** allows you to **bring resources under Terraform management without having to recreate them**.

### Steps to Import Existing Resources into Terraform

1. **Identify the Resource:** First, you need to **identify the resource you want to import**. This typically involves finding the resource's **unique identifier**, such as an ARN (Amazon Resource Name) for AWS resources or a resource ID for other providers.

2. **Declare the Resource in Terraform:** Next, you **declare the resource in your Terraform configuration file (*.tf)**. This is similar to how you define resources that Terraform will create, but instead of providing all the configuration details, you leave them empty.

    Example: To import an existing EC2 Instance, you declare below in *ec2.tf* file

    ```hcl
    resource "aws_instance" "example" {

    }
    ```

3. **Run the Import Command:** Once the resource is declared, you **run the *`terraform import`* command followed by the resource type and the resource identifier**. Terraform will then fetch the current state of the resource from the provider and import it into the Terraform state file (`terraform.tfstate`).

    Example: To import an existing EC2 Instance

    ```hcl
    terraform import aws_instance.example i-1234567890abcdef0

    ```
    This command tells Terraform to import the existing EC2 instance with the ID `i-1234567890abcdef0` and associate it with the resource named `aws_instance.example` in your Terraform configuration.

### Important Note: 

- After importing a resource, **Terraform will not automatically create or manage its configuration**. 
- You'll still need to **review the generated configuration and make any necessary code updates to match your desired state**.
- Example as stated in step 4 below

4. **Update the Configuration:** After importing the resource, you need to update the Terraform configuration file to provide the necessary configuration details, such as resource attributes and dependencies, so that Terraform can manage the resource going forward.

    Example: Update the configuration

    ```hcl
    resource "aws_instance" "example" {
        ami = "ami-123f1ca1bd58a5689"
        instance_type = "t2.micro"
        availability_zone = "us-east-1a"
        key_name = "terraform-demo"
        tags = {
            "Name" = "MyEC2-Linux"
        }
    }
    ```

5. **Apply Changes:** Finally, you apply the changes using `terraform apply` to ensure that Terraform manages the imported resource according to your configuration.

    ```hcl
    terraform apply

    ```

## References : 

https://developer.hashicorp.com/terraform/cli/import

https://developer.hashicorp.com/terraform/cli/import/usage