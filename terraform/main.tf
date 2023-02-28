data "google_client_config" "default" {}

resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  service = each.key
  disable_dependent_services = false
  disable_on_destroy = false
}

resource "time_sleep" "wait_services_enablement" {
  create_duration = "20s"

  depends_on = [google_project_service.gcp_services]
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = "autopilot-vpc"
  subnet_name         = "autopilot-us-central1"
  subnet_name_proxy   = "autopilot-us-central1-proxy"
  cidr_range          = "10.0.0.0/20"
  cidr_range_proxy    = "10.100.0.0/20"
  cidr_pods           = "172.16.0.0/16"
  cidr_services       = "172.17.0.0/16"
  gcp_region          = var.gcp_region
}

module "gke" {
  source              = "./modules/gke"
  cluster_name        = "gke-autopilot"
  subnet_name         = module.vpc.subnet_name
  gcp_project_id      = var.gcp_project_id
  gcp_region          = var.gcp_region
  gcp_zones           = ["us-central1-a","us-central1-b","us-central1-c"]
  vpc_name            = module.vpc.vpc_name
  cidr_pods           = "pods-range"
  cidr_services       = "services-range"
}

module "artifactregistry" {
  source        = "./modules/artifactregistry"
  repository_id = "custom-metrics"
  gcp_region    = var.gcp_region
}