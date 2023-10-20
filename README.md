# Terraform

- ### [00-Terraform-Basics](00-Terraform-Basics) - Terraform Definitions and more
- ### [01-Terraform-Installation](01-Terraform-Installation) - Install Terraform

- ### [02-Terraform-Configuration](01-Terraform-Configuration) - Configure Terraform

- ### [03-Terraform-Terminologies](03-Terraform-Terminologies) - Key Terraform Terminologies
    - **provider** : Define the providers like AWS, Azure, GCP
    - **resource** : Infrastructure Resources to be created, ex: VPC, S3, EC2
    - **Data Sources** (optional) : Pull the data from the provider
    - **variable**: Give user option to enter the value for defined resources
    - **Arguments** : Inputs
    - **Attributes** : Outputs
    - **Meta-Arguments** : Terraform specific Inputs ex: count, for_each,depends_on

- ### [04-Terraform-Top-Level-Blocks](04-Terraform-Top-Level-Blocks) - Terraform Top Level Blocks
    - **Terraform Block** (>0.13 version) or Terraform Settings Block or Terraform Configuration Block 
    - **Provider Block**
    - **Resource Block**
    - **Input Variables Block**
    - **Output Values Block**
    - **Local Values Block**
    - **Data Sources Block**
    - **Modules Block**

- ### [05-Terraform-Commands](05-Terraform-Commands) - Basic Terraform Commands
    - *`terraform init`*
    - *`terraform validate`*
    - *`terraform plan`*
    - *`terraform apply`* or *`terraform apply -auto-approve`*
    - *`terraform destroy`* or *`terraform destroy -auto-approve`*

- ### [06-Terraform-VPC-Demo](06-Terraform-VPC-Demo) - Simple Demo to Create AWS VPC using Terraform



- #### Pending Notes
    - 02-Terraform-Configuration
    - 05-Terraform-Commands
    - 04-Terraform-Top-Level-Blocks
        - Multiple Providers
    
- #### Revise following
    - terraform dependency file ?
    - terraform lock file ?
