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


## Local State vs. Remote State

| **Type**                  | **Local State**                                | **Remote State (AWS S3)**                          |
|---------------------------|------------------------------------------------|----------------------------------------------------|
| **Location**              | Stored **locally** in the project directory.   | Stored in a **remote** backend, e.g., AWS S3.      |
| **Concurrency**           | Not suitable for collaboration. Lacks locking. | **Enables collaboration** with backend locking.    |
| **Security**              | Sensitive information may be exposed.          | **Fine-grained access** control with AWS IAM policies. |
| **Backups**               | Prone to **accidental deletion** or loss.      | **Version Controlled**, Automatic durability & availability with S3.|

### Advantages of Remote State (AWS S3):
- **Collaboration**: Supports team collaboration by providing a centralized location for state files.
- **Locking Mechanisms**: Prevents conflicts during concurrent operations.
- **Security**: Uses AWS IAM roles and policies for access control.
- **Version Controlled** : Take advantage of S3 versioning
- **Durability and Availability**: AWS S3 ensures automatic durability and availability for state files.

### Implementing AWS S3 as a Remote State Backend:

1. [Create S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-bucket.html) on your AWS Account
2. Create folder *tf/dev* (you can choose any name of your choice) here *tf/dev* only mean its terraform and dev environment
3. [Create a DynamoDB table](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/getting-started-step-1.html) for facilitating state file locking
3. use terraform *`backend`* block to configure remote state 

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/key"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
```

**Example**: 



## References : 

Terraform State : https://developer.hashicorp.com/terraform/language/state

<!-- Terraform State : [https://developer.hashicorp.com/terraform/language/state](https://developer.hashicorp.com/terraform/language/state) -->




