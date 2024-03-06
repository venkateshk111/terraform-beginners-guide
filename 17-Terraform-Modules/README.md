# Terraform Modules

**Terraform Modules**

- Terraform modules are **self-contained, reusable units** of infrastructure configuration.
- Terraform modules encapsulate a **collection of Terraform configuration files (typically `.tf` files) within a single directory**. 
- They act as **reusable building blocks** for your infrastructure.

**Benefits of modules:**

-   **Code reusability:** Define infrastructure components once and reuse them throughout your configurations or across projects.
-   **Improved organization:** Break down complex configurations into smaller, manageable modules for better readability and maintainability.
-   **Collaboration:** Share modules with colleagues or within a team, promoting consistency and reducing duplication of effort.

**Module Structure:**

A typical Terraform module directory may contain:

-   `main.tf`       : The main configuration file defining the module's resources using providers.
-   `variables.tf`  : Defines variables that can be customized when using the module.
-   `outputs.tf`    : Defines values that the module can expose to the calling configuration.
-   `README.md`     : optional file for documentation

**Using Modules:**

-   Modules are called (or instantiated) within other Terraform configurations using the **`module`** block.
-   You can **provide values for the module's variables during instantiation**, customizing its behavior.
-   Outputs from a module can be referenced in the calling configuration to use the module's results.
-   **Module arguments:** You can specify constraints on variable types and allowed values to ensure proper usage.
-   **Local vs. Remote Modules:** Modules can reside in the local filesystem (local modules) or be fetched from external sources like the Terraform Registry (remote modules) for sharing and collaboration.

**Benefits of Using Modules:**

-   **Reduced code duplication:** Write code once and reuse it across your infrastructure.
-   **Improved maintainability:** Easier to update and manage infrastructure components in one place.
-   **Modular design:** Promotes a more modular and scalable approach to infrastructure configuration.

