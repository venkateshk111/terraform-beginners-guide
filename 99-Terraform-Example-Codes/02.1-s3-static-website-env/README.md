# Static Website with AWS S3 Bucket

This Terraform project creates a static website hosted on AWS S3 Bucket.


## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/) installed.
- AWS credentials configured.

## Usage

1. Clone this repository.
2. Initialize Terraform:

    ```sh
    terraform init
    ```

3. Create a Terraform execution plan:

    ```sh
    terraform plan -var-file=vars/dev.tfvars
    ```

4. Apply the Terraform configuration:

    ```sh
    terraform apply -var-file=vars/dev.tfvars
    ```

5. Access your website using the provided endpoint:

    ```sh
    terraform output s3_website_endpoint
    ```

## Clean Up

To remove all resources created by this Terraform configuration, run:

```sh
terraform destroy -var-file=vars/dev.tfvars
```

## Terraform Files

### 00_provider.tf

- **Purpose:** Configures the AWS provider.
- **Provider:** AWS.
- **Region:** us-east-1.
- **Tags:** Default tags for resources.

### 01_variables.tf

- **Purpose:** Defines input variables for the project.
- **Variables:**
  - `bucket_name`: Name of the S3 bucket.
  - `env`: Environment name (e.g., dev, prod).

### 02_s3.tf

- **Purpose:** Creates the S3 bucket and configures static website hosting.
- **Steps:**
  1. Create a bucket with a formatted name (`bucket_name-env`).
  2. Enable static website hosting with index and error documents.
  3. Edit Block Public Access settings.
  4. Add a bucket policy to make bucket content publicly accessible.
  5. Configure index document.
  6. Configure error document.

### 03_s3_url.tf

- **Purpose:** Outputs the URL of the static website.
- **Output:**
  - `s3_website_endpoint`: Endpoint URL of the static website.

### vars/dev.tfvars

- **Purpose:** Defines variable values for the `dev` environment.
- **Variables:**
  - `bucket_name`: "venkatesh-s3-30032024"
  - `env`: "dev"



## Reference Documents:

https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object