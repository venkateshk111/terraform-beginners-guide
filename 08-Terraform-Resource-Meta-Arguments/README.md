# Terraform Resource Meta-Arguments

## Terraform Meta Arguments

- Meta Arguments are **special configuration settings used to customize how Terraform manages resources**.
- Terraform Meta Arguments **provide additional instructions and behaviors for how Terraform should manage resources**. 
- Terraform Meta Arguments are used to **customize and fine-tune** the behavior of your infrastructure provisioning.

### List of Terraform Meta Arguments

1. ***`count`***
2. ***`depends_on`***
3. ***`for_each`***
4. ***`provider`***
5. ***`lifecycle`***  
<!-- -->

1. ### ***`count`*** Meta Argument

    - The ***`count`*** Meta Argument allows you to **specify the number of instances of a resource you want to create**. 
    - It's used when you **need multiple identical resources with the same configuration**.
    - ***count*** can be used with modules and with **every resource type**
    - The ***count*** argument **must be a non-negative whole number**. 
    - If ***count*** is **set to 0**, it **will not create any instances of the resource**. 
    - You can also **use expressions** to determine the count dynamically.
    - When each instance is created, it has its own distinct infrastructure object associated with it, so **each can be managed separately**. When the configuration is applied, each object can be created, destroyed, or updated as appropriate.
    - **Note** : A given resource or module block **cannot use both ***count***** and ***for_each*** .

- **Example**:
    ```hcl
    resource "aws_instance" "example" {
        count = 2
        ami           = "ami-0df435f331839b2d6"
        instance_type = "t2.micro"
    }
    ```
