# Terraform Variables

## Custom validation rules for Terraform input variables


- Custom validation rules are a way to **enforce specific conditions** or constraints on the values of your resource attributes. 

- These rules allow you to **define checks that must be satisfied before Terraform accepts the configuration**.

- **Validation Rules**: These are conditions that you set for your resource attributes. They can be as straightforward or as complex as your requirements.

- **Custom Validation**: Terraform allows you to create your own validation rules using the ***`validation`*** block within a resource definition.

- **Use cases** :
    - Ensuring **required parameters are set**.
    - Checking that values meet specific criteria.
    - Verifying that **certain conditions are met before resource creation**.

- **Benefits** :
    - Adds an extra layer of control over your infrastructure.
    - Helps **catch potential misconfigurations** early in the deployment process.
    - Provides meaningful error messages for easier troubleshooting.

- **Example**:  

    [00_provider.tf](./00_provider.tf)
    ```hcl
    terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    }

    provider "aws" {
    region = var.aws_region

    default_tags {
        tags = {
        Terraform = "yes"
        Owner = var.owner
        }
    }
    }
    ```

    [01_ec2.tf](./01_ec2.tf)
    ```hcl
    resource "aws_instance" "myec2" {
    ami = var.ec2_ami
    instance_type = var.ec2_instance_type

    tags = {
        Name = "Linux2023"
        env  = var.env
    }
    }
    ```

    [02_variables.tf](./02_variables.tf)
    ```hcl
    variable "aws_region" {
    description = "AWS Region In Which Resources will be Created"
    type        = string
    default     = "us-east-1"
    }

    variable "owner" {
    description = "Name of the Engineer who is creating Resources"
    type        = string
    default     = "Venkatesh"
    }

    variable "ec2_ami" {
    description = "AWS EC2 AMI Amazon Linux 2023"
    type        = string
    default     = "ami-0df435f331839b2d6" # Amazon Linux 2023
    validation {
        condition = length(var.ec2_ami) > 4 && substr(var.ec2_ami, 0,4) == "ami-"
        error_message = "The EC2 AMI ID value must be a valid AMI id, starting with \"ami-\"."
    }
    }

    variable "ec2_instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t2.micro"
    }

    variable "env" {
    description = "Environment Type"
    type        = string
    default     = "dev"
    }
    ```


- In the above example,
    variable `ec2_ami`: AWS EC2 AMI variable we define custom validation rules that signifies the `ami` id should be id of ***length > 4*** and always start with *`ami-`*
    

To test the custom validation rules lets change the ami id to start differently and see what `terraform` reports

```hcl 
    variable "ec2_ami" {
    description = "AWS EC2 AMI Amazon Linux 2023"
    type        = string
    #default     = "ami-0df435f331839b2d6" # Amazon Linux 2023
    default     = "xyz-0df435f331839b2d6"
    validation {
        condition = length(var.ec2_ami) > 4 && substr(var.ec2_ami, 0,4) == "ami-"
        error_message = "The EC2 AMI ID value must be a valid AMI id, starting with \"ami-\"."
    }
    }
   ```


- ***`terraform plan`*** Output

    - You can notice the validation rules in effect and re `error_message` being displayed to make correction  

    ```hcl
    $ terraform plan

    Planning failed. Terraform encountered an error while generating this plan.

    ╷
    │ Error: Invalid value for variable
    │
    │   on 02_variables.tf line 13:
    │   13: variable "ec2_ami" {
    │     ├────────────────
    │     │ var.ec2_ami is "xyz-0df435f331839b2d6"
    │
    │ The EC2 AMI ID value must be a valid AMI id, starting with "ami-".
    │
    │ This was checked by the validation rule at 02_variables.tf:18,3-13.
    ```


## References : 

[Terraform Custom Conditions](https://developer.hashicorp.com/terraform/language/expressions/custom-conditions)


