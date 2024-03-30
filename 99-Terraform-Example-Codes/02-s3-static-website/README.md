# Configuring a static website on Amazon S3 Using Terraform

This Terraform configuration creates a simple static website hosted on an AWS S3 Bucket.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine
- AWS credentials configured locally

## Usage

1. Clone the repository and navigate to the directory containing the Terraform files.

2. Initialize the Terraform configuration:

    ```bash
    terraform init
    ```

3. Apply the Terraform configuration to create the static website:

    ```bash
    terraform apply
    ```

4. After the apply is successful, the static website will be accessible at the provided S3 bucket website endpoint.

5. To clean up and delete the resources created by Terraform, run:

    ```bash
    terraform destroy
    ```

## Files

- `00_provider.tf`: Configures the AWS provider.
- `01_variables.tf`: Defines variables used in the configuration.
- `02_s3.tf`: Creates an S3 bucket for the static website and configures static website hosting.
- `03_s3_url.tf`: Outputs the URL of the static website.

## Customization

- Modify the `terraform.tfvars` file to change the `bucket_name` variable, which sets the name of the S3 bucket.
- Update the `index.html` and `error.html` files in the `website-files` directory to customize the website content.









https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html



https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block