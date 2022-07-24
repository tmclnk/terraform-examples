# Terraform Basics

- Hashicorp Configuration Language [HCL](https://github.com/hashicorp/hcl)
    - Not YAML
    - Declarative
    - Typed - strings, numbers, lists, maps
- "Providers" for different platforms
    - Providers provide "resources",
      e.g. [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/)
- Modules
    - Group resources together
    - Modules have [Input Variables](./modules/agility-stack/variables.tf)
    - Modules have outputs,
      e.g. [EKS Attributes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#attributes-reference)
- Data Lookups
    - look up latest machine image for an OS
    - look up things you created by hand, e.g. domains you registered

# My Setup

```
export AWS_PROFILE=pg-tom
```
