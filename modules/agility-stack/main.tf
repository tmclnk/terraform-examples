# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"

  # Applied to all resources in this module
  default_tags {
    tags = {
      Environment = var.environment
      Owner = var.owner
      Application = "Agility"
    }
  }
}

# Create a VPC Using Prebuilt Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  name = "${var.environment}-vpc"

  cidr = "10.0.0.0/16"

  azs             = var.aws_azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.103.0/24", "10.0.104.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC Flow Logs
  flow_log_file_format = "plain-text"
}

resource "aws_db_instance" "app_database" {
  instance_class = "db.t4g.micro"
  allocated_storage = var.db_size
  engine = "postgres"

  db_subnet_group_name = module.vpc.database_subnet_group_name
  tags = {
    Name = "${var.environment}-app-db"
  }
}