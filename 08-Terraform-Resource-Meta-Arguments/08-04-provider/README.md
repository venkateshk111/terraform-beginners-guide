##  Terraform Resource Meta-Arguments

2. ### ***`provider`*** Meta Argument

    - The ***provider*** Meta Argument is used



    - **Example**:    
    [00_provider.tf](./00_provider.tf)
        ```hcl
        
        ```


- Lets Execute Terraform commands to understand resource behavior

    1. ***`terraform init`*** : *Initialize* terraform
    2. ***`terraform validate`*** : *Validate* terraform code
    3. ***`terraform fmt`*** : *format* terraform code
    4. ***`terraform plan`*** : *Review* the terraform plan
    5. ***`terraform apply`*** : *Create* Resources by terraform
        - Example of *`terraform apply`*
            ![terraform apply](./imgs/path.png)
            ![terraform apply](./imgs/path.png)


        - After you type ***yes*** to *`terraform apply`* prompt, terraform will start **creating** resources.
            ![terraform apply](./imgs/path.png)

        - Once terraform completes the execution you should be able to check on your AWS Console four S3 buckets created successfully
            ![terraform aws](./imgs/path.png)


    #### Cleanup 
 
    6. ***`terraform destroy`*** : *destroy or delete* Resources, Cleanup the resources we created
        - After you type ***yes*** to *`terraform destroy`* prompt, terraform will start **destroying** resources

        ![terraform destroy](./imgs/path.png)


        - Once terraform completes the execution you should be able to check on your AWS Console both S3 buckets are successfully deleted.
        ![terraform destroy](./imgs/path.png)

### References :
