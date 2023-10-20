# Terraform Resource

## Terraform Resource Block

- A **Terraform Resource** is a fundamental unit used to model and manage infrastructure components. 

- Each resource block describes one or more ***infrastructure objects*** that you want to create, modify, or manage.
    - Example :  ***s3 bucket***, ***ec2 instance***, ***RDS instance***, ***Security Group***, ***VPC***

- [**resource Syntax**](https://developer.hashicorp.com/terraform/language/resources/syntax)
    ```hcl
    resource "type" "name" {
        argument1 = "value1"
        argument2 = "value2"
        ......... = "......"
        ......... = "......"
        argumentn = "valuen"
    }
    ```

- **Example of a Resource Block:**

    ```hcl
    resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    
    tags = {
    Name = "Linux"
    }

    }
    ```
    ![Resource](./imgs/tf-resource.png)

    - **`resource`:** The keyword to start a ***resource*** block.
    - **`aws_instance`:** 
        - The **resource type**, which defines what you're creating (e.g., an AWS EC2 instance).
        - Resource type determines the kind of infrastructure object it manages and what arguments and other attributes the resource supports
    - **`example`**:
        - The **resource name**, which is a unique identifier within your configuration.
        - Its a Local name ("example"). 
        - The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside that module's scope.
    - **`ami`, `instance_type` and `tags`:** Arguments or the Configuration parameters specific to the resource you're defining.


## Terraform Resource Behaviors

Terraform resource behaviors refer to,
- How Terraform manages and interacts with resources in your infrastructure. 
- These behaviors determine how resources are
    - ***created***
    - ***updated***
    - ***destroyed***

1. ***Create*** :
   - Terraform attempts to **create resources** in your target infrastructure based on your configuration.
   - Terraform ***creates* resources** that exist in the configuration but are not associated(present) with a real infrastructure object in the state

2. ***Destroy*** :
   - ***Destroys* resources** that exist in the state/infra but no longer exist in the configuration.
   - Removing a resource from your Terraform configuration leads to the planned destruction of that resource in the infrastructure.

3. ***Update in-place*** :
   - ***update* the resources** whose arguments have changed
   - Terraform detects differences between the desired state in your configuration and the current state in the infrastructure. It plans and applies changes to update resources accordingly.

4. ***Destroy and re-create*** :
   - Terraform will ***destroy and re-create* resources** whose arguments have changed but which cannot be updated in-place due to remote API limitations


5. ***Dependency Management*** :
   - Terraform ensures dependent resources are created or updated before resources that rely on them to avoid issues.

6. ***Concurrency Control*** :
   - Terraform manages resource operation concurrency to prevent conflicts and ensure consistency.

7. ***State Management*** :
   - Terraform maintains a state file that records the current state of the infrastructure, which is used to plan and apply updates.













### References :
- [https://developer.hashicorp.com/terraform/language/resources/syntax](https://developer.hashicorp.com/terraform/language/resources/syntax)
- [https://developer.hashicorp.com/terraform/language/resources/behavior](https://developer.hashicorp.com/terraform/language/resources/behavior)