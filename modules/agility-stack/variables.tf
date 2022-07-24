################################################################################
# Variables Declarations
################################################################################
variable "environment" {
  description = "Environment name, e.g. dev, test prod."
  type = string
}

variable "owner" {
  description = "Organization that owns this resource."
  type = string
}

variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "aws_azs" {
  description = "Availability Zones (pick 2 in the region specified by aws_region)."
  type = list(string)
}

variable "db_instance_class" {
  description = "Instance class for the app database."
  type = string
}

variable "db_size" {
  description = "Size, in GB, of database volume."
  type = number
}

