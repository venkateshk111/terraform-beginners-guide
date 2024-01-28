# Terraform State

## Terraform State File

- The Terraform state file (*`terraform.tfstate`*) is a critical component in managing infrastructure.
- The state is used by Terraform 
    - **to map real world resources to your configuration**
    - **keep track of metadata**
    - **To improve performance** for large infrastructures
- Terraform uses state **to determine which changes to make to your infrastructure**. 
- Prior to any operation, Terraform does a ***refresh*** to update the state with the real infrastructure.

### Purpose of the State File:

1. **Tracking Resources**: Stores the current state of defined resources with details like resource IDs and IP addresses.

2. **Dependency Management**: Manages dependencies between resources, ensuring correct application order for changes.

3. **Concurrency and Locking**: Handles concurrent access by using state locks to prevent conflicts.

### State File Location:

- By default, the state file is **stored locally in the same directory**. 
- For large Enterprise Infrastructure, it's recommended to use ***remote backends*** (**AWS S3, Azure Storage, terraform Cloud** etc.) to enable collaboration and avoid local state file issues.
- Using a **remote backend enhances security, collaboration, and version control** in Terraform workflows.


## References : 

Terraform State : https://developer.hashicorp.com/terraform/language/state

<!-- Terraform State : [https://developer.hashicorp.com/terraform/language/state](https://developer.hashicorp.com/terraform/language/state) -->




