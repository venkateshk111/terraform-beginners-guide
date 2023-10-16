# Terraform Terminologies

## Terraform Provider, Resource, Data Sources, and Variables

### Provider:

- A Terraform provider is a **plugin** that enables Terraform to interact with a specific infrastructure or service provider. 

- Providers are responsible for **translating the Terraform configurations into API calls that create, modify, or delete resources** in the target environment.

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

### Data Sources:
- Data sources in Terraform allow you to **fetch information from an external system** or existing resources in your infrastructure. 
- They are ***read-only*** and provide a way to import existing data into your Terraform configuration.

- **Example:**
    ```hcl
    data "aws_ami" "latest_amazon_linux" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    }

    ```
    Here, **aws_ami** is a data source that fetches information about the latest Amazon Linux AMI.

### Variables:

- Variables in Terraform are placeholders for values that can be used throughout your configuration. 
- Variables allow you to parameterize your configurations, making them more flexible and reusable.  
- Variables can be declared in a separate file or directly in the main configuration.

- **Example:**
    ```hcl
    variable "aws_region" {
    type    = string
    default = "us-west-2"
    }

    resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    region        = var.aws_region
    }
    ```
    In this example, **aws_region** is a variable that defines the AWS region. It is referenced within the **aws_instance** resource.

## Terraform Arguments, Attributes, and Meta-arguments

### Arguments:

- Arguments are the **input parameters** that you provide when defining a resource in Terraform. 
- They represent the configuration details for a specific resource.

- **Example:**
    ```hcl
    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }
    ```
    In this example, **ami** and **instance_type** are arguments provided when creating an **aws_instance** resource.

### Attributes:
- Attributes represent the **output** or **result** of a resource after it has been created. 
- These are values that you can reference in other parts of your Terraform configuration.

- **Example:**
    ```hcl
    output "instance_id" {
    value = aws_instance.example.id
    }
    ```
    Here, **aws_instance.example.id** is an attribute of the **aws_instance** resource, and we're creating an output named **instance_id** to expose this value.

### Meta-Arguments:

- Meta-arguments are terraform specific arguments.  
- Meta-arguments are used to modify the behavior of resources or define how Terraform should manage certain aspects of the infrastructure. 
- commonly used meta-arguments : ***count***, ***for_each***, ***depends_on***

- **Example:**
    - ***count***  

    ```hcl
    resource "aws_instance" "example" {
    count         = 2
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    }
    ```
    In this case, ***count*** is a meta-argument that specifies the **number of instances to create**.

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