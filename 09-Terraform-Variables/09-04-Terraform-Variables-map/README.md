# Terraform Variables

## Implement variable type as `map`


- **map (or object)**: a **group of values identified by named labels**, like[tmicro = "t2.micro", tsmall= "t2.small"]. 
- Elements in a list or tuple are identified by key, [tmicro], [tsmall]

Let's consider the `ec2_instance_type` variable as an example and Implement List function 

### Previous Definition:

```hcl
variable "ec2_instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t2.micro"
}
```

To utilize a list as a complex type constructor for *instance_type*, you can modify it like this:
### *map* type

```hcl
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = map(string)
  default = {
    tmicro   = "t2.micro"
    tsmall   = "t2.small"
    tlarge   = "t2.large"
  }
}
```

Here's what changed:

- **Type Declaration (type)**: It is now specified as *`map(string)`*, indicating that the variable is expected to be a *`map`* of strings.

- **Default Value (default)**: The default value is now specified as below, indicating that by default, it's a *`map`* containing a three string element, which is *element["tmicro"]="t2.micro", element["tsmall"]="t2.small, and element["tlarge"]="t2.large"*.
    ```hcl
    default = {
    tmicro   = "t2.micro"
    tsmall   = "t2.small"
    tlarge   = "t2.large"
    }
    ```

- In order to use this map type variable in [01_ec2.tf](./01_ec2.tf) you will have to call it using below syntax

    ```hcl
    instance_type = var.ec2_instance_type["tmicro"] # for t2.micro
    instance_type = var.ec2_instance_type["tsmall"] # for t2.small
    instance_type = var.ec2_instance_type["tlarge"] # for t2.large
    ```

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
    instance_type = var.ec2_instance_type["tlarge"]
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
    type        = map(string)
    default = {
        tmicro   = "t2.micro"
        tsmall   = "t2.small"
        tlarge   = "t2.large"
    }
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


- In the above example, We've defined six variables: 
    1. `aws_region`: default AWS Region to be used
    2. `owner`: Name of the Engineer who is creating Resources
    3. `ec2_ami`: AWS EC2 AMI
    4. `ec2_instance_type`: **map of** AWS EC2 Instance type
    5. `instance_count`: Number of EC2 to be Created
    6. `env` : Environment Type (PRE, PRD, DEV, UAT)


- ***`terraform plan`*** Output for ***`var.ec2_instance_type["tlarge"] (for t2.large)`***:
    - You can notice the change in `instance_type` to *t2.large* when `var.ec2_instance_type["tlarge"]` is used.

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
                + "env"  = "dev"
                }
            + tags_all                             = {
                + "Name"      = "Linux2023"
                + "Owner"     = "Venkatesh"
                + "Terraform" = "yes"
                + "env"       = "dev"
                }
            + tenancy                              = (known after apply)
            + user_data                            = (known after apply)
            + user_data_base64                     = (known after apply)
            + user_data_replace_on_change          = false
            + vpc_security_group_ids               = (known after apply)
            }

        Plan: 1 to add, 0 to change, 0 to destroy.
        ```
- Similarly if you pass `var.ec2_instance_type["tmicro"]` or `var.ec2_instance_type["tsmall"]`, the `instance_type` will be *t2.micro* and *t2.small* respectively



## References : 

[Types and Values](https://developer.hashicorp.com/terraform/language/expressions/types)

[Type Constraints *map*](https://developer.hashicorp.com/terraform/language/expressions/types#map)

