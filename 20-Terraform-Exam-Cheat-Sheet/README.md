# Terraform Certification Exam Cheat Sheet

## Terraform

- **Cloud-agnostic** :
  - Manages infrastructure across different cloud providers 
  - Example: AWS, Azure, Google Cloud and on-premises environments.
  
- **Declarative** :
  - Uses HashiCorp Configuration Language (HCL) to describe infrastructure's desired state.
  - Specifies resources, configurations, and relationships in code.
  - Terraform determines necessary actions to achieve desired state and executes them.
  
- **Immutable** :
  - Treats infrastructure as immutable.
  - Creates new resources or replaces existing ones to match desired state.
  - Does not modify existing resources; creates new version based on updated configuration.
  - Replaces old infrastructure with new one based on updated configuration.

- **Idempotence**: 
  - Ensure that applying the same configuration multiple times has the same result as applying it once, reducing the risk of configuration drift.

- **Version Control**: 
  - Store infrastructure configurations in version control systems (e.g., Git) to track changes, facilitate collaboration, and enable rollbacks.

- **Self-describing infrastructure**
  - Infrastructure can be described in a way that its purpose, configuration, and dependencies are clear and understandable without needing to inspect the actual infrastructure

- **Terraform workflow**  

    1\. *`Write a Terraform configuration`* (.tf) file   
    2. *`terraform init`* : **Initializing** the Terraform working directory  
    3. *`terraform plan`* : **Planning** the infrastructure changes  
    4. *`terraform apply`*: **Applying** the changes with terraform apply to create the new infrastructure  

- Terraform configuration can be written in
    - HashiCorp Configuration Language (HCL)
    - JSON  

- **List of All Supported OS**
    - macOS
    - Windows
    - Linux
        - Ubuntu/Debian
        - CentOS/RHEL
        - Fedora
        - Amazon Linux
    - FreeBSD
    - OpenBSD
    - Solaris
    - More details : https://developer.hashicorp.com/terraform/install 
    
## provider block

- A **provider is a plugin** that allows Terraform to interact with a specific cloud provider or service
- A provider configuration block is **NOT required in every Terraform configuration**. 
- provider is only required when you are using a specific provider to manage resources
- Providers **can be written by individuals**
- Providers **can be maintained by a community of users**
- **Some providers are maintained by HashiCorp**
- **Major cloud vendors and non-cloud vendors can write, maintain**, or collaborate on Terraform providers


## provisioners

- *`remote-exec`*
    - Executes **commands on a remote resource over SSH or WinRM** after it has been created. 
    - This can be used for initial configuration, software installation, or other tasks.
    - example run shell or PS commands on remote EC2
- *`local-exec`*
    - Executes **commands on the machine running Terraform**, 
    - Used for tasks that cannot be performed on the remote resource. 
    - example run aws cli commands from local machine running terraform
- *`file`*
    - **Copies files or directories** from the machine running Terraform to the newly created resource
    - file provisioner supports ***`ssh`*** and ***`winrm`*** connection types

## state file *`terraform.tfstate`*
- Name of the state file is *`terraform.tfstate`*
- A file that **stores the current state** of infrastructure managed by Terraform
-  **"description"** argument is **NOT stored in the state file**, its is used for providing human-readable descriptions 
- *`terraform.tfstate`* **does NOT** always matches your currently built infrastructure. Its possible someone has made some manual changes on your infrastructure
- `Usernames` and `passwords` referenced in the Terraform code, even as variables, will end up in **plain text in the state file**
- **default location** for *`terraform.tfstate`* is the **current working directory** in which Terraform was run

## Terraform Commands

- *`terraform init`*
- *`terraform plan`*
- *`terraform fmt`*
- *`terraform validate`*
- *`terraform apply`*
- *`terraform apply -replace=aws_instance.{INSTANCE_NAME}`* 
    - recreate the resource during apply (replacement for `terraform taint`)
- *`terraform refresh`*
    - It **updates the state file** to reflect the current state of the infrastructure
    - It **does not process the configuration file**
- *`terraform plan -destroy`*
- *`terraform destroy`*
- *`terraform get`*
- *`terraform state list`*

- *`terraform force-unlock`*
    - use *`force-unlock`* only when automatic unlocking fails

## remote workspace

- You can have single remote workspace and map multiple configurations( multiple state files)


## Terraform Logging

- **`TF_LOG`** - Specify the logging level
- **`TF_LOG_PATH`** - Specify the path for log file
- TF_LOG available values
    - **TRACE** : Provides the **most detailed logging**, this is **highest level**
    - **DEBUG** : Provides debug-level logging
    - **INFO**  : Provides informational logging
    - **WARN**  : Provides warning messages
    - **ERROR** : Provides error messages only

- more details : [Terraform-Debug](../19-Terraform-Debug/README.md)


## Terraform workspaces

## Terraform modules

- A collection of resources that make up a specific piece of infrastructure
- A group of related resources
- terraform modules are used for
    - **Organize** configuration
    - **Encapsulate** configuration
    - **Re-use** configuration

## Terraform sentinel

- policy as code
- can be used to enforce compliance and governance policies before any infrastructure changes are made

## Terraform Cloud Free Tier

- Following are available
    - Private Module Registry
    - VCS Connection
    - Single Sign-On (SSO)
    - Remote Terraform execution

- Following are **NOT** available
    - Team Management
    - Application-level Logging
    - Audit Logging
    - No-code provisioning


- **Terraform Version Constraints** 

    | Constraint                        | Description                                                                                   | Example                       |
    |-----------------------------------|-----------------------------------------------------------------------------------------------|-------------------------------|
    | `>= 1.0.0` (Greater Than or Equal To) | Allows any version greater than or equal to `1.0.0`, such as `1.0.0`, `1.0.1`, `1.1.0`, etc. | `>= 1.0.0`                    |
    | `<= 1.0.0` (Less Than or Equal To)    | Allows any version less than or equal to `1.0.0`, such as `1.0.0`, `0.9.9`, etc.              | `<= 1.0.0`                    |
    | `~> 1.0.0` (Pessimistic Version Constraint) | Allows any version equal to `1.0.0`, or greater, but only up to the next significant release, such as `1.0.0`, `1.0.1`, but not `1.1.0`. | `~> 1.0.0`            |
    | `= 1.0.0` (Exact Version)             | Allows only the exact version `1.0.0`.                                                        | `= 1.0.0`                     |
    | `!= 1.0.0` (Not Equal To)             | Excludes version `1.0.0` but allows any other version.                                         | `!= 1.0.0`                    |


- **Terraform Types**

    | Type     | Description                                                            | Example                                         |
    |----------|------------------------------------------------------------------------|-------------------------------------------------|
    | `string` | Represents a text string.                                             | `"hello"`, `"world"`                            |
    | `number` | Represents a numerical value.                                         | `5`, `10.5`                                     |
    | `list`   | Represents a list of values.                                          | `[1, 2, 3]`, `["a", "b", "c"]`                  |
    | `map`    | Represents a collection of key-value pairs.                           | `{key1 = "value1", key2 = "value2"}`            |

- **Terraform Functions**

    | Function                | Description                                                            | Example                                           |
    |-------------------------|------------------------------------------------------------------------|---------------------------------------------------|
    | `element(list, index)`  | Returns the element at the specified index in a list.                  | `element([1, 2, 3], 1)` returns `2`                |
    | `format(format_string, arguments)` | Formats a string using placeholders and values.                | `format("Hello, %s!", "world")` returns `"Hello, world!"` |
    | `join(separator, list)` | Joins together elements of a list into a single string using a separator. | `join(", ", ["a", "b", "c"])` returns `"a, b, c"`      |
    | `lookup(map, key, default)` | Looks up a value in a map based on a key, with an optional default value. | `lookup({a = "apple", b = "banana"}, "a", "default")` returns `"apple"` |

- **Structural Types:**

    | Type     | Description                                        | Example                   |
    |----------|----------------------------------------------------|---------------------------|
    | `string` | Represents text, such as words or sentences.       | `"hello"`, `"world"`      |
    | `number` | Represents numerical values, integers or decimals. | `5`, `10.5`               |
    | `bool`   | Represents boolean values, true or false.          | `true`, `false`           |
    | `list`   | Represents a list of values of the same type.      | `[1, 2, 3]`, `["a", "b"]` |


- **Complex Types:**

    | Type       | Description                                                                                   | Example                                            |
    |------------|-----------------------------------------------------------------------------------------------|----------------------------------------------------|
    | `map`      | Represents a collection of key-value pairs, similar to a dictionary.                         | `{key1 = "value1", key2 = "value2"}`               |
    | `object`   | Represents a complex structure with multiple attributes, each with its own type.             | `{name = "John", age = 30, is_active = true}`       |
    | `tuple`    | Represents a fixed-size collection of elements, where each element can have a different type.| `["apple", 1, true]`                               |
    | `set`      | Represents a collection of unique elements.                                                  | `["apple", "banana", "cherry"]`                    |


- ### Terraform Cloud different tiers 

    | Feature                               | HCP Free    | HCP Standard | HCP Plus    | HCP Enterprise |
    |---------------------------------------|-------------|--------------|-------------|----------------|
    | Infrastructure as code (HCL, CDKTF)  | Yes         | Yes          | Yes         | Yes            |
    | Workspaces                           | Yes         | Yes          | Yes         | Yes            |
    | Variables                            | Yes         | Yes          | Yes         | Yes            |
    | Runs (separate plan and apply)       | Yes         | Yes          | Yes         | Yes            |
    | Providers                            | Yes         | Yes          | Yes         | Yes            |
    | Modules                              | Yes         | Yes          | Yes         | Yes            |
    | Public registry                      | Yes         | Yes          | Yes         | Yes            |
    | Config-driven import                 | Yes         | Yes          | Yes         | Yes            |
    | Remote state storage                 | Yes         | Yes          | Yes         | Yes            |
    | **VCS connection**                   | Yes         | Yes          | Yes         | Yes            |
    | Projects                             | Yes         | Yes          | Yes         | Yes            |
    | Secure variable storage              | Yes         | Yes          | Yes         | Yes            |
    | **Remote runs (plan & apply)**       | Yes         | Yes          | Yes         | Yes            |
    | Private registry                     | Yes         | Yes          | Yes         | Yes            |
    | Test-integrated module publishing    | 5 modules   | 10 modules   | Unlimited   | Yes            |
    | **Team management**                  | No          | Yes          | Yes         | Yes            |
    | **No-code provisioning**             | No          | No           | Yes         | Yes            |
    | Generated module tests               | No          | No           | Beta        | No             |
    | Cross-organization registry sharing  | No          | No           | No          | Yes            |
    | Workspace management                 | Yes         | Yes          | Yes         | Yes            |
    | Workspace explorer                   | Yes         | Yes          | Yes         | No             |
    | **Audit logging**                    | No          | No           | Yes         | Yes            |
    | Drift detection                      | No          | No           | Yes         | Yes            |
    | Continuous validation                | No          | No           | Yes         | Yes            |
    | Ephemeral workspaces                 | No          | No           | Yes         | Yes            |
    | Runtime metrics (Prometheus)         | No          | No           | No          | Yes            |
    | Dynamic provider credentials         | Yes         | Yes          | Yes         | Yes            |
    | Policy as code (Sentinel and OPA)    | 1 Policy set, 5 Policies | 1 Policy set, 5 Policies | Unlimited | Yes            |
    | Versioned policy sets                | No          | No           | Yes         | Yes            |
    | Policy enforcement level: Advisory   | Unlimited   | Unlimited    | Unlimited   | Yes            |
    | Policy enforcement level: mandatory  | 1 Mandatory | 1 Mandatory  | Unlimited   | Yes            |
    | Run tasks                            | 1 Run task integration, 10 Workspaces attached | 1 Run task integration, 10 Workspaces attached | Unlimited | Yes |
    | Run tasks: advisory enforcement      | Unlimited   | Unlimited    | Unlimited   | Yes            |
    | Run tasks: mandatory enforcement     | 1 Mandatory | 1 Mandatory  | Unlimited   | Yes            |
    | Self-hosted installation             | No          | No           | No          | Yes            |
    | Air gap network deployment           | No          | No           | No          | Yes            |
    | **Application-level logging**        | No          | No           | No          | Yes            |
    | Log forwarding                      | No          | No           | No          | Yes            |
    | Audit trails API                    | No          | No           | Yes         | No             |
    | **Single sign-on**                  | Yes         | Yes          | Yes         | Yes            |
    | Support for ServiceNow integrations | No          | No           | Yes         | Yes            |
    | Run triggers                        | Yes         | Yes          | Yes         | Yes            |
    | Concurrency                         | 1           | 3            | 10          | Uncapped       |
    | Self-hosted agents                  | 1           | 1            | 10          | Uncapped       |
    | Active/active scale-out             | No          | No           | No          | Yes            |
    | Community                           | Yes         | Yes          | Yes         | Yes            |
    | Premium support and services        | No          | Yes          | Yes         | Yes            |






## Terraform types and functions

**Terraform Types**

| Type     | Description                                                            | Example                                         |
|----------|------------------------------------------------------------------------|-------------------------------------------------|
| `string` | Represents a text string.                                             | `"hello"`, `"world"`                            |
| `number` | Represents a numerical value.                                         | `5`, `10.5`                                     |
| `list`   | Represents a list of values.                                          | `[1, 2, 3]`, `["a", "b", "c"]`                  |
| `map`    | Represents a collection of key-value pairs.                           | `{key1 = "value1", key2 = "value2"}`            |

**Terraform Functions**

| Function                | Description                                                            | Example                                           |
|-------------------------|------------------------------------------------------------------------|---------------------------------------------------|
| `element(list, index)`  | Returns the element at the specified index in a list.                  | `element([1, 2, 3], 1)` returns `2`                |
| `format(format_string, arguments)` | Formats a string using placeholders and values.                | `format("Hello, %s!", "world")` returns `"Hello, world!"` |
| `join(separator, list)` | Joins together elements of a list into a single string using a separator. | `join(", ", ["a", "b", "c"])` returns `"a, b, c"`      |
| `lookup(map, key, default)` | Looks up a value in a map based on a key, with an optional default value. | `lookup({a = "apple", b = "banana"}, "a", "default")` returns `"apple"` |

**Structural Types:**

| Type     | Description                                       | Example                   |
|----------|----------------------------------------------------|---------------------------|
| `string` | Represents text, such as words or sentences.       | `"hello"`, `"world"`      |
| `number` | Represents numerical values, integers or decimals. | `5`, `10.5`               |
| `bool`   | Represents boolean values, true or false.          | `true`, `false`           |
| `list`   | Represents a list of values of the same type.      | `[1, 2, 3]`, `["a", "b"]` |


**Complex Types:**

| Type       | Description                                                                                   | Example                                            |
|------------|-----------------------------------------------------------------------------------------------|----------------------------------------------------|
| `map`      | Represents a collection of key-value pairs, similar to a dictionary.                         | `{key1 = "value1", key2 = "value2"}`               |
| `object`   | Represents a complex structure with multiple attributes, each with its own type.             | `{name = "John", age = 30, is_active = true}`       |
| `tuple`    | Represents a fixed-size collection of elements, where each element can have a different type.| `["apple", 1, true]`                               |
| `set`      | Represents a collection of unique elements.                                                  | `["apple", "banana", "cherry"]`                    |

