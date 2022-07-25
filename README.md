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

## What Terraform Doesn't Do

Terraform does _not_ do things like...

- Conditional if/then creation logic
-
- Provide a GUI
- Configure VMs (use ansible, chef, puppet)

## How Do I Use This

### Install Terraform

[Install Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Or use `brew`, `apt`, `yum`, or whatever. You'll (probably?) need Python 3.

The Jetbrains plugin for terraform is excellent. The VSCode plugin is also good. I used plain `vim` for about a year and
was reasonably productive.

### Terraform CLI

```shell
# You'll need AWS keys and permissions to create resources....
# I've got keys in a profile called "pg-tom"
export AWS_PROFILE=pg-tom

# Run from the directory of the env
cd environments/dev

# Initialize the plugin the first time and create any .tfstate files
terraform init
```

### Creating and Modifying Resources

The usual development cycle once the directory is created is

```shell
# preview changes before applying, like a dry-run
terraform plan

# apply the changes. some resources, like databases and caches, can take
# several minutes to create; don't panic
terraform apply
```

### Cleaning Up

```
terraform destroy
```

## What Does This Create

- A VPC spread across two AZs with 4 subnets in each VPC (public, private, database, cache). Routing tables between the
  subnets. This is roughly the network topography you'd expect if applying the AWS Well Architected Framework.
- A small EC2 instance
- A Postgres database
- A Redis cache
- An EKS Cluster (maybe, if I get to it)

# Alternative Technologies

Terraform overlaps in different ways with...

- The AWS CLI
- AWS Libraries (namely boto3)
- The AWS Console
- CloudFormation (most similar)
