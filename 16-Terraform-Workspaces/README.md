# Terraform Workspaces

- Terraform workspaces allow you to **manage different sets of infrastructure resources** using the **same Terraform configuration** by isolating state files. 
- **Each workspace can have its own state**, allowing you to work on different environments (like development, staging, and production) without affecting each other. 
- Terraform starts with a *default* workspace named "***default***" that you cannot delete.
- Workspaces are **not a substitute for separate Terraform configurations** if you need different credentials or access controls for each environment.
- Note : The Terraform CLI workspaces are different from workspaces in Terraform Cloud.


## Workspace Commands

Following commands help you manage and switch between different environments or configurations easily.

- - *`terraform workspace --help`* : print help message for workspace commands


- *`terraform workspace new <name>`*: Creates a new workspace.
- *`terraform workspace select <name>`*: Switches to an existing workspace.
- *`terraform workspace list`*: Lists all available workspaces.
- *`terraform workspace show`*: Shows the current workspace.
- *`terraform workspace delete <name>`*: Deletes a workspace.



## References : 


https://developer.hashicorp.com/terraform/language/state/workspaces

https://developer.hashicorp.com/terraform/cli/workspaces
