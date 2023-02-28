// gke module
variable "cluster_name" {
  description = "The name of the Cluster to create"
  type        = string
}

variable "subnet_name" {
  description = "The name of the Subnet to create"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID"
  type = string
}

variable "gcp_region" {
  description = "The GCP region"
  type = string
}

variable "gcp_zones" {
  description = "The GCP zones"
  type = list
}

variable "vpc_name" {
  description = "The name of the VPC where the cluster will be created"
  type        = string
}

variable "cidr_pods" {
  description = "The Secondary CIDR range for pods"
  type = string
}

variable "cidr_services" {
  description = "The Secondary CIDR range for services"
  type = string
}
