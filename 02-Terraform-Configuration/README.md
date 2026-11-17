# Terraform Configuration

After installing Terraform, we need to **configure our local machine** so that Terraform can talk to AWS. This guide works for **Windows, Mac and Linux**.

To run Terraform against AWS from your laptop, you need these things:

1. **Terraform CLI** installed (see [Terraform-Installation](/01-Terraform-Installation/README.md))
2. **AWS CLI** installed
3. **AWS credentials** configured on your machine
4. A **working folder** with a provider configuration, to test everything

## Step 1: Verify Terraform Installation

Open a **new** terminal (PowerShell on Windows, Terminal on Mac and Linux) and run:

```
terraform -version
```

You should see something like this:

```
Terraform v1.x.x
on windows_amd64
```

- If you get **"terraform is not recognized"** or **"command not found"**, close the terminal and open a new one. The PATH is loaded only when a terminal starts.
- If it still does not work, the folder where Terraform is installed is missing in your **PATH** environment variable. Add it and open a new terminal.

## Step 2: Install AWS CLI

Terraform does not need AWS CLI to run, but AWS CLI is the easiest way to **store credentials** and to **check that they work** before running Terraform.

### Windows

- Using Chocolatey:
    ```
    choco install awscli -y
    ```
- Or download and run the MSI installer from [AWS CLI installation page](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### Mac

```
brew install awscli
```

### Linux

```
curl "https://awscli.amazonaws.com/awscliv2.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Verify

Open a new terminal and run:

```
aws --version
```

## Step 3: Create AWS Credentials

Terraform needs permission to create resources in your AWS account. We give this permission using **credentials**.

- **Important Note:** Never use the **root user** access keys. Create an **IAM user** (or use **IAM Identity Center** if your organization uses it) and use that.

For learning, the simplest way is an IAM user with an access key:

1. Login to the AWS Console and open **IAM**
2. Create a new **IAM user** (example name: `terraform-user`)
3. Attach the permissions that you need. For a **personal learning account**, `AdministratorAccess` is the easiest. For any shared or work account, give only the permissions required.
4. Enable **MFA** for the user
5. Open the user, go to **Security credentials**, and click **Create access key**. Choose **Command Line Interface (CLI)** as the use case
6. Copy the **Access key ID** and **Secret access key**. The secret key is shown only once

- **Important Note:** Never commit access keys to Git, never paste them in a blog or a screenshot, and delete the keys when you do not need them anymore.

## Step 4: Configure Credentials on Your Machine

### Option A: Access keys using aws configure

```
aws configure
```

It asks four questions:

```
AWS Access Key ID [None]: <your access key id>
AWS Secret Access Key [None]: <your secret access key>
Default region name [None]: us-east-1
Default output format [None]: json
```

The credentials are saved in the **default** profile, and Terraform picks it up automatically.

This creates two files in a hidden `.aws` folder in your home directory:

| OS | Location |
|----|----------|
| Windows | `C:\Users\<username>\.aws\credentials` and `config` |
| Mac and Linux | `~/.aws/credentials` and `~/.aws/config` |

### Option B: IAM Identity Center (SSO)

If your organization uses IAM Identity Center (SSO), use this instead of access keys:

```
aws configure sso
aws sso login
```

When it asks for the CLI profile name, enter `default`, so that Terraform picks it up automatically.

The SSO session expires after some time. When it expires, run `aws sso login` again.

### Check that the credentials work

```
aws sts get-caller-identity
```

You should see your account ID and user:

```
{
    "UserId": "AIDAXXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-user"
}
```

If this command works, Terraform will work too, because Terraform reads credentials the same way AWS CLI does.

## Step 5: Tell Terraform Which Region to Use

Terraform uses the **default profile** that we created with `aws configure`, so we do not need to give any credentials in the code. We only set the region in the provider block:

```hcl
provider "aws" {
    region = "us-east-1"
}
```

The region can also come from an environment variable. If you set both, the provider block wins.

Mac and Linux:
```
export AWS_REGION=us-east-1
```

Windows PowerShell:
```
$env:AWS_REGION = "us-east-1"
```

Windows Command Prompt:
```
set AWS_REGION=us-east-1
```

These variables are valid only for the current terminal. If you close the terminal, you have to set them again.

- **Important Note:** Do not put access keys directly in the provider block. Use `aws configure`, SSO or environment variables.
- If you ever use a **named profile** (created with `aws configure --profile name`), add `profile = "name"` in the provider block, or set the `AWS_PROFILE` environment variable.

## Step 6: Create Your First Terraform Folder

Create a new folder and open it in your editor (we will use VS Code):

```
mkdir terraform-lab
cd terraform-lab
```

Create a file named `main.tf` with this content:

```hcl
terraform {
    required_version = ">= 1.5.0"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

data "aws_caller_identity" "current" {}

output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
    value = data.aws_caller_identity.current.arn
}
```

This configuration **does not create any resource**. It only asks AWS "who am I?" using a data source and prints the answer. So it is **free and safe** to test your setup.

## Step 7: Run and Test

Run these commands from the `terraform-lab` folder.

1. **Initialize**
    ```
    terraform init
    ```
    Terraform downloads the AWS provider and creates a `.terraform` folder and a `.terraform.lock.hcl` file. You should see **"Terraform has been successfully initialized!"**

2. **Plan**
    ```
    terraform plan
    ```
    You will see the two outputs that will be shown after apply.

3. **Apply**
    ```
    terraform apply
    ```
    Type `yes` when it asks. You should see something like this:
    ```
    Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

    Outputs:

    account_id = "123456789012"
    caller_arn = "arn:aws:iam::123456789012:user/terraform-user"
    ```

If you can see your own account ID, **your Terraform setup is working**.

- **Important Note:** Your account ID is not a secret, but it is better not to share it in public screenshots.

## Step 8: Create a .gitignore File

If you plan to push your Terraform code to GitHub, create a `.gitignore` file in the folder:

```
.terraform/
*.tfstate
*.tfstate.*
crash.log
*.tfvars
```

- The `.terraform` folder has downloaded providers, so no need to push it.
- State files can have **sensitive values** in plain text, so never push them.
- `.tfvars` files often have environment specific or sensitive values.
- **Do commit** the `.terraform.lock.hcl` file, so that everyone uses the same provider versions.

## Optional Setup

### VS Code Extension

Install the **HashiCorp Terraform** extension in VS Code. It gives syntax highlighting, auto-completion and format on save for `.tf` files.

### Tab Completion (Mac and Linux)

If you use Bash or Zsh, you can enable tab completion for Terraform commands:

```
terraform -install-autocomplete
```

Restart your shell after this. This option is not available for PowerShell.

### Plugin Cache (saves download time)

The AWS provider is a big download, and Terraform downloads it again in every new folder. A plugin cache folder avoids this.

1. Create the cache folder
    - Mac and Linux:
        ```
        mkdir -p ~/.terraform.d/plugin-cache
        ```
    - Windows PowerShell:
        ```
        mkdir $env:APPDATA\terraform.d\plugin-cache
        ```
2. Create the Terraform CLI configuration file
    - Mac and Linux: `~/.terraformrc`
    - Windows: `%APPDATA%\terraform.rc`
3. Add this line (use your own path):
    - Mac and Linux:
        ```
        plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
        ```
    - Windows (use forward slashes):
        ```
        plugin_cache_dir = "C:/Users/<username>/AppData/Roaming/terraform.d/plugin-cache"
        ```

## Common Problems and Fixes

| Error or problem | Reason | Fix |
|------------------|--------|-----|
| `terraform` is not recognized or command not found | PATH is not updated, or the terminal was open during installation | Open a new terminal. If it still fails, add the Terraform folder to PATH |
| `No valid credential sources found` or `failed to get shared config profile` | Terraform cannot find credentials | Run `aws configure` again, and check that `aws sts get-caller-identity` works in the same terminal |
| `InvalidClientTokenId` or `The security token included in the request is invalid` | Wrong or inactive access key, or a typo while copying | Create a new access key and run `aws configure` again |
| `ExpiredToken` or SSO errors | SSO session expired | Run `aws sso login` |
| `AccessDenied` or `UnauthorizedOperation` | The IAM user does not have permission for that action | Add the required permission to the IAM user |
| `MissingRegion` or `Invalid region` | Region is not set or has a typo | Set `region` in the provider block or set `AWS_REGION` |
| `Failed to query available provider packages` during init | Internet, firewall or proxy is blocking the download | Check your network. Behind a proxy, set the `HTTPS_PROXY` environment variable |

## References

* [Install Terraform (HashiCorp)](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Install or update AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [Configure AWS CLI settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
* [AWS provider authentication and configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)
* [HashiCorp Terraform extension for VS Code](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
