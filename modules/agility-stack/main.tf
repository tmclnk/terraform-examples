# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  # Applied to all resources in this module
  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
      Application = "Agility"
    }
  }
}

# Create a VPC Using Prebuilt Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  name    = "${var.environment}-vpc"

  cidr = "10.0.0.0/16"

  azs                 = var.aws_azs
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets    = ["10.0.103.0/24", "10.0.104.0/24"]
  elasticache_subnets = ["10.0.105.0/24", "10.0.106.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC Flow Logs
  flow_log_file_format = "plain-text"

}

#resource "aws_elasticache_cluster" "app_cache" {
#  cluster_id      = "${var.environment}-redis"
#  engine          = "redis"
#  node_type       = "cache.t3.micro"
#  num_cache_nodes = 1
#  port            = 6379
#}

resource "aws_db_instance" "app_database" {
  instance_class    = "db.t4g.micro"
  allocated_storage = var.db_size
  engine            = "postgres"
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name = module.vpc.database_subnet_group_name
  tags                 = {
    Name = "${var.environment}-app-db"
  }
}

resource "aws_instance" "app_instance" {
  instance_type = "t3.nano"
  subnet_id     = module.vpc.private_subnets[0]
  ami           = data.aws_ami.ubuntu.image_id
  tags          = {
    Name = "${var.environment}-app-instance"
  }

}

################################################################################
# Kubernetes!
################################################################################
#resource "aws_iam_role" "example" {
#  name = "eks-cluster-example"
#
#  assume_role_policy = <<POLICY
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "eks.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole"
#    }
#  ]
#}
#POLICY
#}
#
#resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#  role       = aws_iam_role.example.name
#}
#
## Optionally, enable Security Groups for Pods
## Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
#resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#  role       = aws_iam_role.example.name
#}
#
#resource "aws_eks_cluster" "example" {
#  name     = "example"
#  role_arn = aws_iam_role.example.arn
#
#  vpc_config {
#    subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]
#  }
#
#  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#  depends_on = [
#    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
#  ]
#}