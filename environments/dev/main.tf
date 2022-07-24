module "app_stack" {
  source = "../../modules/agility-stack"
  environment = "dev"
  owner = "houston"
  aws_region = "us-east-2"
  aws_azs = ["us-east-2b", "us-east-2c"]
  db_instance_class = "db.t4g.micro"
  db_size = 10
}
