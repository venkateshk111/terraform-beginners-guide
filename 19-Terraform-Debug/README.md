# Terraform Debug

## Terraform Debug Basics

- Terraform Debug is a feature that allows you to **troubleshoot and diagnose issues with your Terraform configurations and state**.


## Environmental Variables
1. **`TF_LOG`** - Specify the logging level
2. **`TF_LOG_PATH`** - Specify the path for log file


### TF_LOG available values

- **TRACE** : Provides the most detailed logging, including extensive information about internal operations and API requests/responses.

- **DEBUG** : Provides debug-level logging, including detailed information about Terraform's actions and decisions.

- **INFO**  : Provides informational logging, showing high-level information about what Terraform is doing.

- **WARN**  : Provides warning messages, indicating potential issues or non-fatal errors.

- **ERROR** : Provides error messages only, indicating critical issues that prevent Terraform from completing an operation.


### Example setup Trace logging in Terraform
1.  Run the following commands   
    ```shell
    export TF_LOG=TRACE
    export TF_LOG_PATH="terraform-trace.log"

    echo $TF_LOG
    echo $TF_LOG_PATH

    ```
2.  You can than execute terraform commands to get the **`TRACE`** logs stored in **`terraform-trace.log`** file  

    ```shell
    # Terraform Initialize
    terraform init

    # Terraform Validate
    terraform validate

    # Terraform Plan
    terraform plan

    # Terraform Apply
    terraform apply -auto-approve

    # Terraform Destroy
    terraform destroy -auto-approve

    # Clean-Up
    rm -rf .terraform*
    rm -rf terraform.tfstate*
    rm terraform-trace.log
    ```


### Setting up Environment Variables permanently for your developer machines

#### Linux Bash
- Open your `.bashrc` which is located in your $home directory 

    ```shell
    # Linux Bash
    cd $HOME
    vi .bashrc

    # Terraform log settings
    export TF_LOG=TRACE
    export TF_LOG_PATH="terraform-trace.log"

    # Verify after saving the file in new terminal 
    $ echo $TF_LOG
    TRACE
    $ echo $TF_LOG_PATH
    terraform-trace.log
    ```

#### Windows Powershell
- Setup using Powershell profile
- Open `$profile` command in a PowerShell
- Once that file is opened add the following lines.
- Now close and reopen the console and type the following to verify that it worked.
    ```powershell
    # Windows Powershell - Terraform log settings
    $env:TF_LOG="TRACE"
    $env:TF_LOG_PATH="terraform.txt"

    # Open new powershell window & Verify
    echo $env:TF_LOG
    echo $env:TF_LOG_PATH
    ```

#### MAC OS
- Update the values in `.bash_profile` at the end of file
    ```shell
    # MAC OS
    cd $HOME
    vi .bash_profile

    # Terraform log settings
    export TF_LOG=TRACE
    export TF_LOG_PATH="terraform-trace.log"

    # Verify after saving the file in new terminal 
    $ echo $TF_LOG
    TRACE
    $ echo $TF_LOG_PATH
    terraform-trace.log
    ```

### Terraform Crash Log
- If Terraform ever crashes (a "panic" in the Go runtime), it saves a log file with the debug logs from the session as well as the panic message and backtrace to `crash.log`.
- Generally speaking, this log file is meant to be passed along to the developers via a GitHub Issue. 
- [How to read a crash log?](https://www.terraform.io/docs/internals/debugging.html#interpreting-a-crash-log)


References:

https://developer.hashicorp.com/terraform/internals/debugging 