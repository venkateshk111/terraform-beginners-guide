# Terraform Top Level Blocks
- **Terraform Block** or Terraform Settings Block (>0.13 version)
- **Provider Block**
- **Resource Block**
- **Input Variables Block**
- **Output Values Block**
- **Local Values Block**
- **Data Sources Block**
- **Modules Block**

### **Terraform Block**

- Terraform block is used to specify various **settings that apply to the entire Terraform project**
- It allows you to **configure global settings** and features.
- Special block used to configure some **behaviours of Terraform** itself
- You define
    - Required **terraform version**
    - **Provider** requirements
    - Configure **terraform state file** (backend)
- Within a terraform block, **only constant values can be used**, arguments may not refer to named objects such as resources, input variables, etc, and may not use any of the Terraform language built-in functions.
- This block is typically defined at the beginning of the Terraform configuration file usually with names like ***backend.tf*** and is enclosed within the ***terraform {}*** syntax
- Example
    ```hcl
    terraform {
    required_version = "~> 0.14.3"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.11"
        }
    }
    backend "s3" {
        bucket = "my-tf-state-bucket"
        key    = "path/to/my/key"
    }
    }
    ```
    In this example:

    - **required_version** :
        - Specifies the minimum required version of Terraform for your configuration. You can use version constraints to ensure compatibility.
        - *~> 0.14.3*: Means any version greater than or equal to 0.14.3 but less than the next significant version (0.15.0).
        - more details here : [https://developer.hashicorp.com/terraform/language/expressions/version-constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)

    - **required_providers** : Specifies the provider requirements

    - **backend** : Specifies the backend configuration for remote state storage. In this case, it's configured to use an S3 bucket as the backend, and you provide the bucket name and key.