################################################################################
# Variables Declarations
################################################################################
variable "environment" {
  description = "Environment name, e.g. dev, test prod."
  type        = string
}

variable "owner" {
  description = "Organization that owns this resource."
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_azs" {
  description = "Availability Zones (pick 2 in the region specified by aws_region)."
  type        = list(string)
}

variable "db_instance_class" {
  description = "Instance class for the app database."
  type        = string
}

variable "db_size" {
  description = "Size, in GB, of database volume."
  type        = number
}

variable "db_username" {
  description = "Administrator username."
  type        = string
}

variable "db_password" {
  description = "Default database password."
  type        = string
}

variable "eks_cluster_max_nodes" {
  description = "Max number of eks nodes."
  type        = number
}

variable "eks_cluster_min_nodes" {
  description = "Minimum number of eks nodes."
  type        = number
}
