module "app_stack" {
  source                = "../../modules/agility-stack"
  environment           = "dev"
  owner                 = "houston"
  aws_region            = "us-east-2"
  aws_azs               = ["us-east-2b", "us-east-2c"]
  db_instance_class     = "db.t4g.micro"
  db_size               = 10
  db_username           = "sa"
  db_password           = "5evECyATYntC2fVfsiETLeocNCC2W3"
  eks_cluster_max_nodes = 2
  eks_cluster_min_nodes = 1
}
