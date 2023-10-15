## What is Terraform ?

- **Terraform** is a tool for building, changing, and versioning infrastructure safely and efficiently. It is used to create/build an environment.

- Terraform can manage existing and popular service providers as well as custom in-house solutions.

- Terraform can be used for multiple cloud providers, like AWS, Azure, or GCP.

- Terraform is developed in the **GO** language.

- Terraform templates are written in a custom Domain Specific Language (DSL) called **HashiCorp Configuration Language** or **HCL**.

- Terraform templates/files end with a **.tf** extension.


## Terraform Basics

**Terraform Definition:**
Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define and provision infrastructure in a declarative configuration language. Terraform supports multiple cloud providers, including AWS, Azure, Google Cloud, and more.

**Key Concepts:**

- **Configuration files** describe to Terraform the components needed to run a single application or your entire datacenter.

- **Execution plan:** Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure.

- **Versioning:** As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.

- The infrastructure Terraform can manage includes low-level components such as **compute instances, storage, and networking**, as well as high-level components such as DNS entries, SaaS features, etc.



- **Declarative Configuration:** Terraform uses declarative syntax, where you define the desired state of your infrastructure. It then determines the necessary actions to bring the actual infrastructure to that state.

- **Infrastructure as Code (IaC):** Terraform enables you to manage and version your infrastructure as code, providing the benefits of version control, collaboration, and repeatability.

- **Providers:** Terraform uses providers to interact with various infrastructure platforms. For AWS, you would use the AWS provider to manage resources within the AWS environment.

**How Terraform Helps with AWS:**
- **Resource Provisioning:** Terraform allows you to define AWS resources such as EC2 instances, S3 buckets, and RDS databases in code. It then provisions and manages these resources based on your configurations.

- **Infrastructure Versioning:** Since Terraform configurations are code, you can version control them using tools like Git. This facilitates collaboration, rollback to previous states, and tracking changes over time.

- **State Management:** Terraform maintains a state file that keeps track of the current state of your infrastructure. This state is crucial for understanding what Terraform has created and managing changes to the infrastructure.


<!-- 
## Terraform Installation
### Windows
Simplest way to install and configure terraform on windows is via [chocolatey](https://chocolatey.org/)

1. Download and Install Chocolatey Software as highlighted here [https://chocolatey.org/install](https://chocolatey.org/install)
2. Install terraform via chocolatey using below command or refer [https://community.chocolatey.org/packages/terraform](https://community.chocolatey.org/packages/terraform)  

    ```
    choco install terraform -y
    ```
    ![Terraform Installation](./imgs/01_choco_install_terraform.png)
### Linux

* [Terraform Installation on Linux](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Mac
* [Terraform Installation on Mac](https://learn.hashicorp.com/tutorials/terraform/install-cli)
 -->
