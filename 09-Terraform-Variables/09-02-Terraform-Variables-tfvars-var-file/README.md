# Terraform Variables

## Overriding `default` Variable values with different `.tfvars` using *`-var-file`* Option

## Using multiple `.tfvars` for Environment-Specific Configurations

In Terraform, you can create multiple `.tfvars` to meet you environment specific variables
- You can manage configurations for different environments, such as pre-production and production, by using separate `.tfvars` files. 
- Each `.tfvars` file contains variable overrides specific to its environment. 
- Here's how to set up and use multiple `.tfvars` files:
    - Create a separate `.tfvars` file for each environment, such as `pre.tfvars` and `prd.tfvars`.
    - In each `.tfvars` file, specify the variable overrides tailored to that environment.

- You can use `terraform plan` or `terraform apply` command in any of the below way

    - *terraform plan -var-file ./vars/pre.tfvars*
    - *terraform plan -var-file="./vars/pre.tfvars"*
    - *terraform plan -var-file=./vars/pre.tfvars*

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
    #region = "us-east-1"
    region = var.aws_region

    default_tags {
        tags = {
        Terraform = "yes"
        #Owner = "Venkatesh"
        Owner = var.owner
        }
    }
    }
    ```

    [01_ec2.tf](./01_ec2.tf)
    ```hcl
    resource "aws_instance" "myec2" {
    # terraform arguments without variables
    # ami = "ami-0df435f331839b2d6"
    # instance_type = "t2.micro"
    # count = 1

    # using variables for arguments
    ami           = var.ec2_ami
    instance_type = var.ec2_instance_type
    count         = var.instance_count

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
    }

    variable "ec2_instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t2.micro"
    }

    variable "instance_count" {
    description = "Number of EC2"
    type        = number
    default     = 1
    }

    variable "env" {
    description = "Environment Type"
    type        = string
    default     = "dev"
    }
    ```

    ***`pre.tfvars`***: 
    [pre.tfvars](./vars/pre.tfvars)

    ```hcl
    instance_type = "t3.small"
    env           = "PRE"
    ```

    ***`prd.tfvars`***:
   [prd.tfvars](./vars/prd.tfvars)
    ```hcl
    instance_type = "t3.large"
    env           = "PRD"
    ```


- In the above example, We've defined five variables: 
    1. `aws_region`: default AWS Region to be used
    2. `owner`: Name of the Engineer who is creating Resources
    3. `ec2_ami`: AWS EC2 AMI
    4. `ec2_instance_type`: AWS EC2 Instance type
    5. `instance_count`: Number of EC2 to be Created
    6. `env` : Environment Type (PRE, PRD, DEV, UAT)


- ***`terraform plan`*** Output for ***`pre.tfvars`***:
    - You can notice the change in `ec2_instance_type` to *t3.small* and `env` to *PRE* on the tags picked up as defined in [*pre.tfvars*](./vars/pre.tfvars) file

        ```hcl
        $ terraform plan -var-file="./vars/pre.tfvars"

        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # aws_instance.myec2[0] will be created
        + resource "aws_instance" "myec2" {
            + ami                                  = "ami-0df435f331839b2d6"
            + arn                                  = (known after apply)
            + associate_public_ip_address          = (known after apply)
            + availability_zone                    = (known after apply)
            + cpu_core_count                       = (known after apply)
            + cpu_threads_per_core                 = (known after apply)
            + disable_api_stop                     = (known after apply)
            + disable_api_termination              = (known after apply)
            + ebs_optimized                        = (known after apply)
            + get_password_data                    = false
            + host_id                              = (known after apply)
            + host_resource_group_arn              = (known after apply)
            + iam_instance_profile                 = (known after apply)
            + id                                   = (known after apply)
            + instance_initiated_shutdown_behavior = (known after apply)
            + instance_lifecycle                   = (known after apply)
            + instance_state                       = (known after apply)
            + instance_type                        = "t3.small"
            + ipv6_address_count                   = (known after apply)
            + ipv6_addresses                       = (known after apply)
            + key_name                             = (known after apply)
            + monitoring                           = (known after apply)
            + outpost_arn                          = (known after apply)
            + password_data                        = (known after apply)
            + placement_group                      = (known after apply)
            + placement_partition_number           = (known after apply)
            + primary_network_interface_id         = (known after apply)
            + private_dns                          = (known after apply)
            + private_ip                           = (known after apply)
            + public_dns                           = (known after apply)
            + public_ip                            = (known after apply)
            + secondary_private_ips                = (known after apply)
            + security_groups                      = (known after apply)
            + source_dest_check                    = true
            + spot_instance_request_id             = (known after apply)
            + subnet_id                            = (known after apply)
            + tags                                 = {
                + "Name" = "Linux2023"
                + "env"  = "PRE"
                }
            + tags_all                             = {
                + "Name"      = "Linux2023"
                + "Owner"     = "Venkatesh"
                + "Terraform" = "yes"
                + "env"       = "PRE"
                }
            + tenancy                              = (known after apply)
            + user_data                            = (known after apply)
            + user_data_base64                     = (known after apply)
            + user_data_replace_on_change          = false
            + vpc_security_group_ids               = (known after apply)
            }

        Plan: 1 to add, 0 to change, 0 to destroy.
        ```

- ***`terraform plan`*** Output for ***`prd.tfvars`***:

    - You can notice the change in `ec2_instance_type` to *t3.large* and `env` to *PRD* on the tags picked up as defined in [*prd.tfvars*](./vars/prd.tfvars) file  
    
        ```hcl
        $ terraform plan -var-file ./vars/prd.tfvars 

        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # aws_instance.myec2[0] will be created
        + resource "aws_instance" "myec2" {
            + ami                                  = "ami-0df435f331839b2d6"
            + arn                                  = (known after apply)
            + associate_public_ip_address          = (known after apply)
            + availability_zone                    = (known after apply)
            + cpu_core_count                       = (known after apply)
            + cpu_threads_per_core                 = (known after apply)
            + disable_api_stop                     = (known after apply)
            + disable_api_termination              = (known after apply)
            + ebs_optimized                        = (known after apply)
            + get_password_data                    = false
            + host_id                              = (known after apply)
            + host_resource_group_arn              = (known after apply)
            + iam_instance_profile                 = (known after apply)
            + id                                   = (known after apply)
            + instance_initiated_shutdown_behavior = (known after apply)
            + instance_lifecycle                   = (known after apply)
            + instance_state                       = (known after apply)
            + instance_type                        = "t3.large"
            + ipv6_address_count                   = (known after apply)
            + ipv6_addresses                       = (known after apply)
            + key_name                             = (known after apply)
            + monitoring                           = (known after apply)
            + outpost_arn                          = (known after apply)
            + password_data                        = (known after apply)
            + placement_group                      = (known after apply)
            + placement_partition_number           = (known after apply)
            + primary_network_interface_id         = (known after apply)
            + private_dns                          = (known after apply)
            + private_ip                           = (known after apply)
            + public_dns                           = (known after apply)
            + public_ip                            = (known after apply)
            + secondary_private_ips                = (known after apply)
            + security_groups                      = (known after apply)
            + source_dest_check                    = true
            + spot_instance_request_id             = (known after apply)
            + subnet_id                            = (known after apply)
            + tags                                 = {
                + "Name" = "Linux2023"
                + "env"  = "PRD"
                }
            + tags_all                             = {
                + "Name"      = "Linux2023"
                + "Owner"     = "Venkatesh"
                + "Terraform" = "yes"
                + "env"       = "PRD"
                }
            + tenancy                              = (known after apply)
            + user_data                            = (known after apply)
            + user_data_base64                     = (known after apply)
            + user_data_replace_on_change          = false
            + vpc_security_group_ids               = (known after apply)
            }

        Plan: 1 to add, 0 to change, 0 to destroy.

        ```



## References : 

[Variable Definitions (.tfvars) Files](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files)

