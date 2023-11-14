# Terraform Variables

Lets Explore
- Terraform Variables with `default` Option
- Overriding `default` Variable values with `-var` Option
- Overriding `default` Variable values with `Environment Variables` Options

## Terraform Variables with `default` Option

In Terraform, variables are placeholders that allow you to input data into your configurations, making your Terraform code more flexible and reusable.

- Variables are containers for **storing and managing values, such as text, numbers, or complex data**. These values can be used within your Terraform code.

- Variables are used to **parameterize your configurations**, allowing you to customize your infrastructure. 
- You can define variables for various settings like *regions, instance types,* etc.

- Variables are declared in your Terraform code using the ***`variable`*** block. You specify the **variable's name**, **type**, and an **optional default value**.

- When running Terraform, you can input values for variables, either by specifying them in a separate variable file or through command-line arguments.

- Variables make your code reusable. You can use the same Terraform configuration with different input values, making it adaptable to different environment (prd, pre, uat, dev).

- **Variable Defaults**: When declaring variables in your Terraform configuration, you can set **default** values. These defaults act as placeholders and are used when no other value is provided.

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
    ```


- In the above example, We've defined five variables: 
    1. `aws_region`: default AWS Region to be used
    2. `owner`: Name of the Engineer who is creating Resources
    3. `ec2_ami`: AWS EC2 AMI
    4. `ec2_instance_type`: AWS EC2 Instance type
    5. `instance_count`: Number of EC2 to be Created

- Each variable has a specific **data type** (*string* or  *number*) and *optional default values*.

- With these variables, you can customize the AMI, instance type, and the number of EC2 instances you want to create, making your Terraform configuration adaptable and flexible

- ***`terraform plan`*** Output

    ```hcl
    $ terraform plan

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
        + instance_type                        = "t2.micro"
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
            }
        + tags_all                             = {
            + "Name"      = "Linux2023"
            + "Owner"     = "Venkatesh"
            + "Terraform" = "yes"
            }
        + tenancy                              = (known after apply)
        + user_data                            = (known after apply)
        + user_data_base64                     = (known after apply)
        + user_data_replace_on_change          = false
        + vpc_security_group_ids               = (known after apply)
        }

    Plan: 1 to add, 0 to change, 0 to destroy.
    ```

## Overriding `default` Variable values with `-var` Option


In Terraform, you can override the default values defined in a variable file using the ***`-var`*** option while running *`terraform plan`* or *`terraform apply`* commands. This allows you to provide custom values for variables **during command execution**.


- **Variable Overrides**: To customize these variables during *`plan`* or *`apply`*, you can use the ***`-var`*** option, followed by the variable name and the new value. This enables you to replace the default value with the value you specify.

**Example**:

- Override *`owner`*:

    ```shell
    terraform apply -var="owner=Amar"

    ```

- Override *`ec2_instance_type`* and *`instance_count`* :

    ```shell
    terraform apply -var="ec2_instance_type=m4.large" -var="instance_count=2"

    ```

- ***`terraform plan`*** Output
    - You can notice the change in `instance_type` to `"m4.large"` and you also see **2 EC2 instances** `aws_instance.myec2[0]` and `aws_instance.myec2[1]` being created.

    ```hcl
    $ terraform plan -var="ec2_instance_type=m4.large" -var="instance_count=2"

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
        + instance_type                        = "m4.large"
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
            }
        + tags_all                             = {
            + "Name"      = "Linux2023"
            + "Owner"     = "Venkatesh"
            + "Terraform" = "yes"
            }
        + tenancy                              = (known after apply)
        + user_data                            = (known after apply)
        + user_data_base64                     = (known after apply)
        + user_data_replace_on_change          = false
        + vpc_security_group_ids               = (known after apply)
        }

    # aws_instance.myec2[1] will be created
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
        + instance_type                        = "m4.large"
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
            }
        + tags_all                             = {
            + "Name"      = "Linux2023"
            + "Owner"     = "Venkatesh"
            + "Terraform" = "yes"
            }
        + tenancy                              = (known after apply)
        + user_data                            = (known after apply)
        + user_data_base64                     = (known after apply)
        + user_data_replace_on_change          = false
        + vpc_security_group_ids               = (known after apply)
        }

    Plan: 2 to add, 0 to change, 0 to destroy.

    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

    Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
    ```

    - You can also create *`terraform plan`* output file with *`-out`* option and use that file as input to apply
    - Note: **when** *`terraform apply`* **is used with plan file than it wont prompt for approval** instead it will apply immediately

    **Example:**

    ```hcl
    # Generate Terraform plan file
    terraform plan -var="ec2_instance_type=m4.large" -var="instance_count=2" -out tfplan_05112023.plan

    # Deploy Terraform Resources using Plan file
    terraform apply tfplan_05112023.plan
    ```
    - In above example terraform will over ride default values for `ec2_instance_type` and `instance_count` and deploy the resources using Plan file  


## Overriding `default` Variable values with `Environment Variables` Options

In Terraform, you can override input variables using environment variables, providing a way to customize your configurations without modifying the Terraform code.

- **Environment Variables:** 
    - Environment variables are a way to store values that can be accessed by different programs or scripts. 
    - In Terraform, you can use environment variables to override the values of input variables during the execution of Terraform commands.
    - To override input variables with environment variables, Prefix the name of the input variable with ***`TF_VAR_`***
    - **Syntax**
        - *`TF_VAR_variable_name=value`* where `variable_name` is name of your input variable
        - use the *`export`* command to set the Environment Variable
    
    - **Example**
        ```shell
        # SET Environment Variables
        export TF_VAR_ec2_instance_type=t2.large
        export TF_VAR_owner=Amar
        echo $TF_VAR_ec2_instance_type, $TF_VAR_owner
        ```

- ***`terraform plan`*** Output

    - You can notice the change in `instance_type` to `"t2.large"` and `Owner` to "`Amar`"

        ```hcl
        Venkatesh@LenovoPC MINGW64 /d/StudyRelated/terraform-beginners-guide/09-Terraform-Variables/09-01-Terraform-Variables-default (main)
        $ export TF_VAR_ec2_instance_type=t2.large

        Venkatesh@LenovoPC MINGW64 /d/StudyRelated/terraform-beginners-guide/09-Terraform-Variables/09-01-Terraform-Variables-default (main)
        $ export TF_VAR_owner=Amar

        Venkatesh@LenovoPC MINGW64 /d/StudyRelated/terraform-beginners-guide/09-Terraform-Variables/09-01-Terraform-Variables-default (main)
        $ echo $TF_VAR_ec2_instance_type, $TF_VAR_owner
        t2.large, Amar

        Venkatesh@LenovoPC MINGW64 /d/StudyRelated/terraform-beginners-guide/09-Terraform-Variables/09-01-Terraform-Variables-default (main)
        $ terraform plan

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
            + instance_type                        = "t2.large"
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
                }
            + tags_all                             = {
                + "Name"      = "Linux2023"
                + "Owner"     = "Amar"
                + "Terraform" = "yes"
                }
            + tenancy                              = (known after apply)
            + user_data                            = (known after apply)
            + user_data_base64                     = (known after apply)
            + user_data_replace_on_change          = false
            + vpc_security_group_ids               = (known after apply)
            }

        Plan: 1 to add, 0 to change, 0 to destroy.

        ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

        Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" 
        now.

        Venkatesh@LenovoPC MINGW64 /d/StudyRelated/terraform-beginners-guide/09-Terraform-Variables/09-01-Terraform-Variables-default (main)
        $
        ```
    - Use *`unset`* command to remove the Environment Variables

        ```shell
        # SET Environment Variables
        unset TF_VAR_ec2_instance_type
        unset TF_VAR_owner
        echo $TF_VAR_ec2_instance_type, $TF_VAR_owner
        ```

## Terraform Variable Precedence

- If the same variable is assigned multiple values, Terraform uses the **last value it finds**, overriding any previous values. 
- Note that the **same variable cannot be assigned multiple values within a single source**.
- Terraform loads variables in the following order, with later sources taking precedence over earlier ones:  

    **5**\. `Environment variables`  
    **4**\. The `terraform.tfvars` file, if present.  
    **3**\. The `terraform.tfvars.json` file, if present.  
    **2**\. Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.  
    **1**\. Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)  



## References : 

[Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

[Environment Variable TF_VAR_name](https://developer.hashicorp.com/terraform/cli/config/environment-variables#tf_var_name)

[Variable Definition Precedence](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)
