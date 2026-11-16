# Terraform Terminologies

## Terraform Provider, Resource, Data Sources, and Variables

### Provider:

- A Terraform provider is a **plugin** that enables Terraform to interact with a specific infrastructure or service provider. 

- Providers are responsible for **translating the Terraform configurations into API calls that create, modify, or delete resources** in the target environment.

- Providers are downloaded from the **Terraform Registry** when you run `terraform init`.

- Provider Syntax
    ```hcl
    provider "provider-name" {
        argument1 = "value1"
        argument2 = "value2"
        ......... = "......"
        ......... = "......"
        argumentn = "valuen"
    }
    ```

- **Example:**
    ```hcl
    provider "aws" {
        region = "us-east-1"
    }
    ```
    Here, **aws** is the provider, and it is configured to interact with AWS resources in the us-east-1 region.

- **Declaring the provider and its version:**

    It is a good practice to tell Terraform which provider to download and which version to use. This is done inside the `terraform` block.

    ```hcl
    terraform {
        required_providers {
            aws = {
                source  = "hashicorp/aws"
                version = "~> 6.0"
            }
        }
    }
    ```
    Here, **source** is where Terraform downloads the provider from, and **version** is a version constraint. `~> 6.0` means any 6.x version, but not 7.0.

- **Important:** Never hardcode your AWS access key and secret key inside the provider block. Use an IAM role, AWS CLI profile or environment variables instead.

### Resource:
- A resource in Terraform represents **a piece of infrastructure** or a **component** in a specific provider. 

- Resources are the building blocks of your infrastructure, and they are declared in your Terraform configuration. 

- Each resource has a type, a name, and a set of configuration parameters.

- Resource Syntax
    ```hcl
    resource "type" "name" {
        argument1 = "value1"
        argument2 = "value2"
        ......... = "......"
        ......... = "......"
        argumentn = "valuen"
    }
    ```

- **Example:**
    ```hcl
    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }
    ```
    In this example, **aws_instance** is the resource type, and example is the resource name. It represents an AWS EC2 instance.

- The first part of the resource type tells you which provider it belongs to. For example, **aws**_instance belongs to the aws provider.

- Resource type and resource name together form the **resource address**, like `aws_instance.example`. This is how you refer to this resource in other parts of the configuration.

- The AMI ID used above is just an example. AMI IDs are **region specific**, so replace it with a valid AMI ID from your own region.

### Data Sources:
- Data sources in Terraform allow you to **fetch information from an external system** or existing resources in your infrastructure. 
- They are ***read-only***. Terraform only reads the information, it does not create or manage anything.
- Data sources are not the same as `terraform import`. A data source just looks up the information so that you can use it in your configuration.

- **Example:**
    ```hcl
    data "aws_ami" "latest_amazon_linux" {
        most_recent = true
        owners      = ["amazon"]

        filter {
            name   = "name"
            values = ["al2023-ami-2023.*-x86_64"]
        }
    }
    ```
    Here, **aws_ami** is a data source that fetches information about the latest Amazon Linux 2023 AMI.

- To use the value, we refer to it with the **data.** prefix:
    ```hcl
    resource "aws_instance" "example" {
        ami           = data.aws_ami.latest_amazon_linux.id
        instance_type = "t2.micro"
    }
    ```

> **Important Note:** When you use `most_recent = true`, the AMI returned by the data source changes whenever AWS publishes a new AMI. On the next `terraform plan`, Terraform will see a different `ami` value and will want to **replace your running EC2 instance** (destroy and create again). This is not what we want for existing servers.
>
> **Example:** Say you created an EC2 instance today using the data source, and it picked AMI `ami-0aaa111`. After a month AWS publishes a new Amazon Linux 2023 AMI `ami-0bbb222`. When you run `terraform plan` again without changing any code, you will see something like this:
>
> ```
>   # aws_instance.example must be replaced
> -/+ resource "aws_instance" "example" {
>       ~ ami = "ami-0aaa111" -> "ami-0bbb222" # forces replacement
>         # (other attributes hidden)
>     }
>
> Plan: 1 to add, 0 to change, 1 to destroy.
> ```
>
> The `-/+` symbol and the "forces replacement" comment mean that your running server will be destroyed and created again, even though you did not change anything in your code.
>
> There are two simple ways to avoid this:
> - **Pin the AMI ID** using a variable or hardcode it, and update it only when you decide to.
> - Keep the data source but add the lifecycle block below in the resource, so new instances get the latest AMI but the existing ones are left alone.
>
> ```hcl
> resource "aws_instance" "example" {
>     ami           = data.aws_ami.latest_amazon_linux.id
>     instance_type = "t2.micro"
>
>     lifecycle {
>         ignore_changes = [ami]
>     }
> }
> ```

### Variables:

- Variables in Terraform are placeholders for values that can be used throughout your configuration. 
- Variables allow you to parameterize your configurations, making them more flexible and reusable.  
- Variables can be declared in a separate file (like `variables.tf`) or directly in the main configuration.

- **Example:**
    ```hcl
    variable "aws_region" {
        type    = string
        default = "us-east-1"
    }

    variable "ami_id" {
        type        = string
        description = "AMI ID for the EC2 instance (region specific)"
        default     = "ami-0c55b159cbfafe1f0"
    }

    provider "aws" {
        region = var.aws_region
    }

    resource "aws_instance" "example" {
        ami           = var.ami_id
        instance_type = "t2.micro"
    }
    ```
    In this example, **aws_region** and **ami_id** are variables. They are referenced using the **var.** prefix. The region is set in the **provider** block, which is the usual place to set it. The AMI is pinned using a variable, so it only changes when you change it.

- **Common variable types:** `string`, `number`, `bool`, `list`, `map`, `set`, `object`

- **Other useful options inside a variable block:**
    - **description**: explains what the variable is for
    - **default**: value used when nothing else is provided
    - **validation**: a rule to check the value before using it
    - **sensitive**: hides the value in plan and apply output (the value is still stored in the state file)

- **Ways to provide values for variables:**
    - `default` value inside the variable block
    - `terraform.tfvars` or `*.auto.tfvars` file
    - `-var` or `-var-file` option on the command line
        ```
        terraform apply -var="aws_region=ap-south-1"
        ```
    - Environment variables starting with `TF_VAR_`
        ```
        export TF_VAR_aws_region=ap-south-1
        ```

## Terraform Arguments, Attributes, and Meta-arguments

### Arguments:

- Arguments are the **input parameters** that you provide when defining a block in Terraform. 
- They represent the configuration details. Arguments are used in resources, data sources, providers and modules.

- **Example:**
    ```hcl
    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }
    ```
    In this example, **ami** and **instance_type** are arguments provided when creating an **aws_instance** resource.

### Attributes:
- Attributes are the **values that you can read** from a resource (or a data source). 
- This includes the arguments you have set, and also the values that AWS gives after the resource is created, like **id**, **arn** or **public_ip**. These are called computed attributes, and you only know them after `terraform apply`.
- You can reference these values in other parts of your Terraform configuration.
- Format to refer an attribute: `resource_type.resource_name.attribute`

- **Example:**
    ```hcl
    output "instance_id" {
        value = aws_instance.example.id
    }
    ```
    Here, **aws_instance.example.id** is an attribute of the **aws_instance** resource, and we're creating an output named **instance_id** to expose this value.

- **Arguments vs Attributes:** Arguments are what you **give** to Terraform. Attributes are what you **get back** (and read) from Terraform.

### Meta-Arguments:

- Meta-arguments are Terraform-specific arguments.  
- Meta-arguments are used to modify the behavior of resources or define how Terraform should manage certain aspects of the infrastructure. 
- They can be used with any resource type, unlike normal arguments which depend on the provider.
- There are five meta-arguments : ***count***, ***for_each***, ***depends_on***, ***provider***, ***lifecycle***

- **Example:**
    - ***count***  

    ```hcl
    resource "aws_instance" "example" {
        count         = 2
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"

        tags = {
            Name = "server-${count.index}"
        }
    }
    ```
    In this case, ***count*** is a meta-argument that specifies the **number of instances to create**. **count.index** gives the index of each instance (0, 1, 2 ...).

    - ***for_each***  

    ```hcl
    resource "aws_instance" "example" {
        for_each      = toset(["web", "app", "db"])
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"

        tags = {
            Name = each.key
        }
    }
    ```
    Here, ***for_each*** creates one instance for each item in the set. **each.key** gives the current item.

    - **count vs for_each:** Use ***count*** when you just need N identical copies. Use ***for_each*** when each item has its own identity (like web, app, db). With count, if you remove an item from the middle, the items after it get re-indexed and Terraform may destroy and recreate them. With for_each this does not happen because each resource is tracked by its key.

    - ***depends_on***  

    ```hcl
    resource "aws_instance" "web" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }

    resource "aws_instance" "db" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"

        depends_on = [aws_instance.web]
    }
    ```
    Here, ***depends_on*** is a meta-argument that establishes a **dependency relationship between resources**.

    - **Implicit vs Explicit dependency:** Most of the time Terraform finds the order by itself. If one resource refers to another (like `aws_subnet.main.id` inside an instance), Terraform understands that the subnet must be created first. This is an **implicit dependency**. ***depends_on*** is an **explicit dependency**, and it is needed only when there is a hidden dependency that Terraform cannot see from the references.

    - ***provider***  

    ```hcl
    provider "aws" {
        region = "us-east-1"
    }

    provider "aws" {
        alias  = "mumbai"
        region = "ap-south-1"
    }

    resource "aws_instance" "india_server" {
        provider      = aws.mumbai
        ami           = "ami-xxxxxxxxxxxxxxxxx"
        instance_type = "t2.micro"
    }
    ```
    Here, ***provider*** tells Terraform to use a specific provider configuration (the one with alias **mumbai**) for this resource. This is useful for multi-region or multi-account setups. Replace the AMI ID with one that exists in ap-south-1.

    - ***lifecycle***  

    ```hcl
    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"

        lifecycle {
            ignore_changes        = [ami]
            prevent_destroy       = true
            create_before_destroy = true
        }
    }
    ```
    Here, ***lifecycle*** changes how Terraform creates, updates or destroys the resource:
    - **ignore_changes**: Terraform will not try to update the listed arguments, even if they change
    - **prevent_destroy**: Terraform will give an error if any plan tries to destroy this resource
    - **create_before_destroy**: the new resource is created first, and then the old one is destroyed

## Terraform Outputs and Locals

### Outputs:

- Outputs are used to **print or expose values** after `terraform apply`, like an instance ID or a public IP.
- They are also used to pass values from a child module to the root module.

- **Example:**
    ```hcl
    output "instance_public_ip" {
        description = "Public IP of the EC2 instance"
        value       = aws_instance.example.public_ip
    }
    ```
    You can see all the outputs again anytime using `terraform output`.

### Locals:

- Locals are **named values inside a configuration** that you can reuse in multiple places. They help avoid repeating the same expression again and again.
- Variables are the **inputs** from outside, locals are calculated **inside** the configuration and cannot be overridden from outside.

- **Example:**
    ```hcl
    locals {
        environment = "dev"
        common_tags = {
            Project = "terraform-demo"
            Env     = local.environment
        }
    }

    resource "aws_instance" "example" {
        ami           = var.ami_id
        instance_type = "t2.micro"
        tags          = local.common_tags
    }
    ```
    Note that the block is called **locals** but we refer to the values using **local.** (singular).

## Quick Summary

| Term | What it is | AWS example |
|------|------------|-------------|
| Provider | Plugin that talks to the platform's API | `provider "aws"` |
| Resource | Infrastructure that Terraform creates and manages | `aws_instance`, `aws_s3_bucket` |
| Data Source | Read-only lookup of existing information | `data "aws_ami"` |
| Variable | Input value to the configuration | `var.aws_region` |
| Argument | Input you give to a block | `instance_type = "t2.micro"` |
| Attribute | Value you can read from a resource | `aws_instance.example.id` |
| Meta-argument | Terraform-specific argument usable on any resource | `count`, `for_each`, `depends_on`, `provider`, `lifecycle` |
| Output | Value printed or exposed after apply | `output "instance_id"` |
| Local | Reusable named value inside the configuration | `local.common_tags` |
