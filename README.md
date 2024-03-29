# Terraform

<img alt="Terraform" src="https://www.datocms-assets.com/2885/1629941242-logo-terraform-main.svg" width="600px">  

<!-- ![tf word cloud](./imgs/01-tf-word-cloud.png)  -->

- ### [00-Terraform-Basics](00-Terraform-Basics) - Terraform Definitions and more
- ### [01-Terraform-Installation](01-Terraform-Installation) - Install Terraform

- ### [02-Terraform-Configuration](01-Terraform-Configuration) - Configure Terraform

<details> 
<summary> <h3><a href="03-Terraform-Terminologies/README.md">03-Terraform-Terminologies</a></h3> </summary>

- **Provider** : Define the providers like AWS, Azure, GCP
- **Resource** : Infrastructure Resources to be created, ex: VPC, S3, EC2
- **Data Sources** (optional) : Pull the data from the provider
- **Variable**: Give user option to enter the value for defined resources
- **Arguments** : Inputs
- **Attributes** : Outputs
- **Meta-Arguments** : Terraform specific Inputs ex: count, for_each,depends_on
</details> 

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

- ### [07-Terraform-Resources](07-Terraform-Resources) - Understanding Resource behavior
    - ***created***
    - ***destroyed*** 
    - ***updated***

- ### [08-Terraform-Resource-Meta-Arguments](08-Terraform-Resource-Meta-Arguments) - Terraform Meta-Arguments
    1. [***`count`***](08-Terraform-Resource-Meta-Arguments/08-01-count/)
    2. [***`for_each`***](08-Terraform-Resource-Meta-Arguments/08-02-for_each/) 
    3. [***`depends_on`***](08-Terraform-Resource-Meta-Arguments/08-03-depends_on/)
    4. [***`provider`***](08-Terraform-Resource-Meta-Arguments/08-04-provider/) 
    5. [***`lifecycle`***](08-Terraform-Resource-Meta-Arguments/08-05-lifecycle/)

- ### [09-Terraform-Variables](09-Terraform-Variables) - Terraform Variables
    1. [**Terraform Variables with `default` Option**](09-Terraform-Variables/)
    2. [**Overriding `default` Variable values with `-var` Option**](09-Terraform-Variables/)
    3. [**Overriding `default` Variable values with `Environment Variables` Options**](09-Terraform-Variables/)
    4. [**Overriding `default` Variable values with `terraform.tfvars` file**](09-Terraform-Variables/09-01-Terraform-Variables-tfvars/)
    5. [**Overriding `default` Variable values with different `.tfvars` using *`-var-file`* Option**](09-Terraform-Variables/09-02-Terraform-Variables-tfvars-var-file/)
    6. [**Terraform Variables type *list***](09-Terraform-Variables/09-03-Terraform-Variables-list/)
    7. [**Terraform Variables type *map***](09-Terraform-Variables/09-04-Terraform-Variables-map/)
    8. [**Custom Validation Rules**](/09-Terraform-Variables/09-05-Custom-Validation-Rules/)
    9. [**Sensitive Variables**](/09-Terraform-Variables/09-06-Sensitive-Variables/)

- ### [10-Terraform-Outputs](10-Terraform-Outputs) - Terraform Output Values

- ### [11-Terraform-Data-Sources](11-Terraform-Data-Sources) - Terraform Data Sources

- ### [12-Terraform-State](12-Terraform-State) - Terraform State

- ### [13-Terraform-Show](13-Terraform-Show) - Terraform Show (need to update)

- ### [14-Terraform-Refresh](14-Terraform-Refresh) - Terraform Refresh Desired and Current state sync

- ### [15-Terraform-State-Commands](15-Terraform-State-Commands) - Inspect, Modify, and Manage the Terraform state

- ### [16-Terraform-Workspaces](16-Terraform-Workspaces) - Manage multiple sets of infrastructure (dev, uat, pre, and prd) with the same Terraform configuration

- ### [17-Terraform-Modules](17-Terraform-Modules) - Reusable terraform codes






- #### Pending Notes
    - 02-Terraform-Configuration
    - 04-Terraform-Top-Level-Blocks
        - Multiple Providers ( covered in meta argument provider)
     - 05-Terraform-Commands
     - 06-Terraform-VPC-Demo
        - execute the terraform commands to create VPC using vpc.tf and update the command documentation with screenshots     
     - 07-Terraform-Resources
        - Terraform resource behavior for  in place update (add tag) destroy and recreate (change AZ)
    - 08-Terraform-Resource-Meta-Arguments
        - *for_each* for set creating iam user notes
    - 11-Terraform-local-values
    - 13-Terraform-Show

- #### Revise following
    - terraform dependency file ?
    - terraform lock file ?

## Project Work

1.  Create Simple Web Server
    - AWS Components
        - EC2
        - Security Group to allow port 22
        - Security Group to allow port 80, 443
    - Use Terraform variables where ever possible.

## Important Links
- Website: https://www.terraform.io
- Forums: [HashiCorp Discuss](https://discuss.hashicorp.com/c/terraform-core)
- Documentation: [https://www.terraform.io/docs/](https://www.terraform.io/docs/)
- Tutorials: [HashiCorp's Learn Platform](https://learn.hashicorp.com/terraform)
- Certification Exam: [HashiCorp Certified: Terraform Associate](https://www.hashicorp.com/certification/#hashicorp-certified-terraform-associate)

<!-- <img alt="Terraform" src="https://www.datocms-assets.com/2885/1629941242-logo-terraform-main.svg" width="600px"> -->



<details> 
<summary> <h3><a href="04-Terraform-Top-Level-Blocks/README.md">04-Terraform-Top-Level-Blocks</a></h3> </summary>

- **Terraform Block** (>0.13 version) or Terraform Settings Block or Terraform Configuration Block 
- **Provider Block**
- **Resource Block**
- **Input Variables Block**
- **Output Values Block**
- **Local Values Block**
- **Data Sources Block**
- **Modules Block**

</details>



<details> 
<summary> <i>terraform apply</i> </summary>

```hcl
$ terraform apply -var-file 03_secrets.tfvars 

Terraform used the selected providers to generate the following execution plan
+ create
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
</details>
