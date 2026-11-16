# Terraform Terminologies

## Terraform Blocks and Labels

### Blocks:

- Terraform configuration is written using **blocks**. A block is a container that holds the configuration for something, like a provider, a resource or a variable.

- Block Syntax
    ```hcl
    block_type "label1" "label2" {
        argument1 = "value1"
        argument2 = "value2"
    }
    ```

- **Example:**
    ```hcl
    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }
    ```
    Here, a block has three parts:
    - **Block type:** `resource`
    - **Labels:** `"aws_instance"` and `"example"`
    - **Body:** everything inside the curly braces `{ }`

- **Labels** are the names that come after the block type. The number of labels depends on the block type.

    | Block type | Number of labels | Example |
    |------------|------------------|---------|
    | terraform | 0 | `terraform { }` |
    | locals | 0 | `locals { }` |
    | provider | 1 | `provider "aws" { }` |
    | variable | 1 | `variable "aws_region" { }` |
    | output | 1 | `output "instance_id" { }` |
    | module | 1 | `module "vpc" { }` |
    | resource | 2 | `resource "aws_instance" "example" { }` |
    | data | 2 | `data "aws_ami" "latest" { }` |

- **Nested blocks:** A block can also have another block inside it. For example, **filter** inside a data source, **lifecycle** inside a resource, or **ingress** inside a security group.
    ```hcl
    resource "aws_security_group" "web" {
        name = "web-sg"

        ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    ```

- **Block vs Argument:** An argument is a single `name = value` line. A block has curly braces and can contain arguments and other blocks.

- **Comments:** Use `#` or `//` for a single line comment, and `/* ... */` for multiple lines.

## Terraform Block

- The **terraform** block is a special block used to configure **Terraform itself**, not the infrastructure.
- It is used to set the Terraform version, the providers to download, and where to store the state file.

- **Example:**
    ```hcl
    terraform {
        required_version = ">= 1.5.0"

        required_providers {
            aws = {
                source  = "hashicorp/aws"
                version = "~> 6.0"
            }
        }

        backend "s3" {
            bucket = "my-terraform-state-bucket"
            key    = "dev/terraform.tfstate"
            region = "us-east-1"
        }
    }
    ```
    Here,
    - **required_version** tells which Terraform CLI versions can run this configuration.
    - **required_providers** tells which providers to download, and which versions.
    - **backend** tells where Terraform should store the state file.

- **Version constraints:**

    | Operator | Meaning | Example |
    |----------|---------|---------|
    | `=` | Exactly this version | `= 1.5.0` |
    | `!=` | Any version except this one | `!= 1.5.0` |
    | `>`, `>=` | Greater than, or greater than or equal | `>= 1.5.0` |
    | `<`, `<=` | Less than, or less than or equal | `< 2.0.0` |
    | `~>` | Allows only the last number to increase | `~> 6.0` means 6.x, but not 7.0 |

- **Important Note:** Variables and other references are **not allowed** inside the terraform block. You have to use fixed values, so you cannot write `bucket = var.bucket_name` in the backend block.

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

## Terraform Expressions and References

### Expressions:

- An expression is anything on the **right side of an argument**. It can be a simple value, or a reference to something else, or a calculation.

- **Simple values:**
    ```hcl
    name    = "web-server"          # string
    count   = 3                     # number
    enabled = true                  # bool
    azs     = ["us-east-1a", "us-east-1b"]   # list
    tags    = { Env = "dev" }       # map
    ```

### References:

- References are used to **use the value of something that is defined somewhere else** in the configuration.

    | What you refer to | Reference format | Example |
    |-------------------|------------------|---------|
    | Variable | `var.<name>` | `var.aws_region` |
    | Local value | `local.<name>` | `local.common_tags` |
    | Resource | `<type>.<name>.<attribute>` | `aws_instance.example.id` |
    | Data source | `data.<type>.<name>.<attribute>` | `data.aws_ami.latest.id` |
    | Module output | `module.<name>.<output>` | `module.vpc.vpc_id` |
    | Current count index | `count.index` | `count.index` |
    | Current for_each item | `each.key`, `each.value` | `each.key` |

- When a resource is created using **count** or **for_each**, we pick a specific one using an index or a key.
    ```hcl
    aws_instance.example[0].id          # when count is used
    aws_instance.example["web"].id      # when for_each is used
    ```

- When we use a reference, Terraform also understands the dependency, and creates things in the right order (the implicit dependency we discussed in meta-arguments).

### String Interpolation:

- Use `${ }` to put a value inside a string.
    ```hcl
    tags = {
        Name = "${var.environment}-web-server"
    }
    ```
    If environment is **dev**, the name becomes **dev-web-server**.

### Conditional Expression:

- Format: `condition ? value_if_true : value_if_false`
    ```hcl
    instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
    ```
    Here, prod gets a t3.large, and every other environment gets a t2.micro.

### Functions:

- Terraform has many **built-in functions** to work with values. You cannot create your own functions.
- Format: `function_name(argument1, argument2)`

    | Function | What it does | Example |
    |----------|--------------|---------|
    | `length` | Number of items in a list or map | `length(var.azs)` |
    | `join` | Joins list items into a string | `join(",", ["a", "b"])` gives `"a,b"` |
    | `upper` | Converts to upper case | `upper("dev")` gives `"DEV"` |
    | `toset` | Converts a list to a set | `toset(["web", "app"])` |
    | `lookup` | Gets a value from a map by key | `lookup(var.ami_map, "us-east-1")` |
    | `merge` | Combines multiple maps | `merge(local.common_tags, { Name = "web" })` |

- You can try any function using the `terraform console` command.

### For Expression:

- A for expression is used to **create a new list or map from an existing one**.
    ```hcl
    variable "names" {
        type    = list(string)
        default = ["web", "app", "db"]
    }

    locals {
        upper_names = [for n in var.names : upper(n)]
    }
    ```
    Here, **upper_names** becomes `["WEB", "APP", "DB"]`.

### Splat Expression:

- The splat expression `[*]` is a shortcut to get one attribute from **all** the resources created by count.
    ```hcl
    output "all_instance_ids" {
        value = aws_instance.example[*].id
    }
    ```

## Terraform Modules

- A module is **a group of Terraform files kept together in a folder**. It is used to package a set of resources so that you can reuse them.
- Every Terraform configuration is already a module. The folder where you run terraform commands is called the **root module**. The modules that the root module calls are called **child modules**.
- A module takes **variables as inputs** and gives **outputs** back.

- Module Syntax
    ```hcl
    module "name" {
        source = "path or location of the module"
        input1 = "value1"
        input2 = "value2"
    }
    ```

- **Example:**
    ```hcl
    module "web_server" {
        source        = "./modules/ec2"
        instance_type = "t2.micro"
    }

    output "web_server_id" {
        value = module.web_server.instance_id
    }
    ```
    Here, **web_server** is the module name, and **source** points to the folder where the module code is. **instance_type** is an input variable of that module. To use an output of the module we use the **module.** prefix.

- The **source** can be a local path, a module from the Terraform Registry, or a Git repository.

- Modules help us to avoid repeating code, keep a standard way of creating things, and keep large projects organized.

- Note: We will see modules in detail in a dedicated section.

## Terraform Backend and State

### State:

- Terraform keeps a record of all the resources it has created and manages. This record is called the **state**, and it is stored in a **state file** (`terraform.tfstate`).
- The state file maps the resources in your configuration to the real resources in AWS.
- When you run `terraform plan`, Terraform compares your **configuration**, the **state file** and the **real infrastructure** to decide what needs to change.
- Do not edit the state file manually, and do not delete it. If it is lost, Terraform will not know about the resources it created.
- The state file can contain sensitive values in plain text, so keep it in a secure place.

### Drift:

- Drift is when the **real infrastructure is different from what Terraform expects**, usually because someone changed a resource manually from the AWS console.
- `terraform plan` detects the drift and shows what it will change to bring the resource back to the configuration.

### Backend:

- A backend defines **where the state file is stored** and how Terraform operations run.
- By default, Terraform uses the **local** backend, which stores the state file in the project folder.
- For team work, the state is stored in a **remote backend** like an **S3 bucket**, so that everyone uses the same state.
- Backend is configured inside the **terraform** block.

- **Example:**
    ```hcl
    terraform {
        backend "s3" {
            bucket       = "my-terraform-state-bucket"
            key          = "dev/terraform.tfstate"
            region       = "us-east-1"
            encrypt      = true
            use_lockfile = true
        }
    }
    ```
    Here, the state file is stored in the S3 bucket **my-terraform-state-bucket** under the path **dev/terraform.tfstate**. 

- **State locking:** When someone is running `terraform apply`, the state is locked so that two people cannot change it at the same time. With S3, locking is enabled using `use_lockfile = true` in newer Terraform versions. Older setups use a DynamoDB table for locking with the `dynamodb_table` argument.

- After adding or changing a backend, run `terraform init` again.

- Note: We will see state and backend in detail in a dedicated section.

## Other Important Terms

### Terraform Registry:

- The Terraform Registry is the **public library of providers and modules**, available at `registry.terraform.io`.
- When you write `source = "hashicorp/aws"`, Terraform downloads the aws provider from the Registry.

### Dependency Lock File:

- The file `.terraform.lock.hcl` is created when you run `terraform init`.
- It records the **exact provider versions** (and their checksums) that were selected, so that everyone in the team and the pipelines use the same versions.
- Commit this file to Git. To upgrade the provider versions later, run `terraform init -upgrade`.

### Workspaces:

- Workspaces allow you to keep **multiple state files for the same configuration**. For example, one for dev and one for test.
- Every configuration starts with one workspace called **default**.
- Common commands:
    ```
    terraform workspace list
    terraform workspace new dev
    terraform workspace select dev
    ```
- You can use the current workspace name in the code with `terraform.workspace`.

### Provisioners:

- Provisioners are used to **run a script or a command** on the local machine or on a remote resource after the resource is created.
- Common types are **local-exec** (runs on the machine where Terraform is running), **remote-exec** (runs on the remote resource) and **file** (copies files to the remote resource).

- **Example:**
    ```hcl
    resource "aws_instance" "example" {
        ami           = var.ami_id
        instance_type = "t2.micro"

        provisioner "local-exec" {
            command = "echo ${self.private_ip} >> private_ips.txt"
        }
    }
    ```
    Here, after the instance is created, the private IP is saved to a file on the machine running Terraform.

- **Important Note:** Provisioners should be used only as a **last resort**. Terraform does not track what a provisioner did, so it cannot plan or fix it later. Prefer other options like **user_data**, custom AMIs (Packer) or a configuration management tool like Ansible.

## Quick Summary

| Term | What it is | AWS example |
|------|------------|-------------|
| Block | Container for configuration, made of block type, labels and body | `resource "aws_instance" "example" { }` |
| Label | Name given after the block type | `"aws_instance"` and `"example"` |
| Terraform block | Configures Terraform itself (version, providers, backend) | `terraform { required_version = ">= 1.5.0" }` |
| Provider | Plugin that talks to the platform's API | `provider "aws"` |
| Resource | Infrastructure that Terraform creates and manages | `aws_instance`, `aws_s3_bucket` |
| Data Source | Read-only lookup of existing information | `data "aws_ami"` |
| Variable | Input value to the configuration | `var.aws_region` |
| Argument | Input you give to a block | `instance_type = "t2.micro"` |
| Attribute | Value you can read from a resource | `aws_instance.example.id` |
| Meta-argument | Terraform-specific argument usable on any resource | `count`, `for_each`, `depends_on`, `provider`, `lifecycle` |
| Output | Value printed or exposed after apply | `output "instance_id"` |
| Local | Reusable named value inside the configuration | `local.common_tags` |
| Expression | Anything on the right side of an argument (value, reference, function, condition) | `var.env == "prod" ? "t3.large" : "t2.micro"` |
| Module | Group of Terraform files reused as a package | `module "web_server"` |
| State | Record of the resources Terraform manages | `terraform.tfstate` |
| Drift | Real infrastructure differs from the state or configuration | Security group edited in the AWS console |
| Backend | Where the state file is stored | `backend "s3"` |
| Registry | Public library of providers and modules | `registry.terraform.io` |
| Lock file | Records the exact provider versions used | `.terraform.lock.hcl` |
| Workspace | Separate state for the same configuration | `terraform workspace new dev` |
| Provisioner | Runs a script after a resource is created (last resort) | `local-exec`, `remote-exec` |
