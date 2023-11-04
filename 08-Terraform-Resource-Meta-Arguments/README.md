# Terraform Resource Meta-Arguments

## Terraform Meta Arguments

- Meta Arguments are **special configuration settings used to customize how Terraform manages resources**.
- Terraform Meta Arguments **provide additional instructions and behaviors for how Terraform should manage resources**. 
- Terraform Meta Arguments are used to **customize and fine-tune** the behavior of your infrastructure provisioning.

### List of Terraform Meta Arguments

1. [***`count`***](./08-01-count/) : The ***count*** Meta Argument allows you to **specify the number of instances of a resource you want to create**.
2. [***`for_each`***](./08-02-for_each/) : **Create multiple instances of a resource based on the elements of a ***`map`*** or ***`set`*****
3. [***`depends_on`***](./08-03-depends_on/) : **establish ***explicit*** dependencies between resources**
4. [***`provider`***](./08-04-provider/) : use **multiple providers** within the same configuration to **manage resources in different cloud regions or service providers**
5. [***`lifecycle`***](./08-05-lifecycle/) : control specific aspects of **how resources are managed during their lifecycle**. 
<!-- -->

