# Terraform State Commands

- Terraform *state* commands are used
    - To **inspect**, **modify**, and **manage** the Terraform state
    - To **keep track of the state** of your infrastructure
    - **Safely make changes the terraform state** file


##  Terraform State Commands list

### Inspecting State

1. *`terraform state list`*: Lists all resources in the Terraform state.

2. *`terraform state show`*: Shows the attributes of a specific resource in the Terraform state.

3. *`terraform state refresh`*: Updates the Terraform state file with the real-world state of the managed infrastructure.

4. *`terraform state version`*: Prints the Terraform state file format version.

### Moving Resources

5. *`terraform state mv`*: Moves an item in the Terraform state from one ID to another. Useful for renaming resources.

6. *`terraform state rm`*: Removes a resource instance from the Terraform state. Use with caution, as this does not destroy the associated infrastructure.

7. *`terraform state replace-provider`*: Replaces a provider in the Terraform state. Useful for changing provider configurations.

### Disaster Recovery

8. *`terraform state pull`*: Retrieves the current state and outputs it to stdout.

9. *`terraform state push`*: Used to upload a local state file to a remote state backend.

10. *`terraform force-unlock`* : Release a stuck lock on the state file, which can happen if a previous Terraform operation didn't complete successfully and the lock wasn't released properly


### Forcing Re-creation 

11. *`terraform state taint`*: Marks a resource instance as tainted, forcing it to be destroyed and recreated on the next apply.

12. *`terraform state un-taint`*: Removes the "tainted" state from a resource instance, allowing it to be managed normally again.

## References : 


https://developer.hashicorp.com/terraform/cli/state

https://developer.hashicorp.com/terraform/cli/state/inspect

https://developer.hashicorp.com/terraform/cli/state/move

https://developer.hashicorp.com/terraform/cli/state/recover