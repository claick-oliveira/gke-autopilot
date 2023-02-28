// gke module
data "google_client_config" "default" {}

resource "google_service_account" "gke-autopilot-sa" {
  account_id   = "tf-gke-autopilot-sa"
  display_name = "Service Account For GKE ${var.cluster_name}"
  project      = var.gcp_project_id
}

resource "google_project_iam_member" "artifactregistry-role" {
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke-autopilot-sa.email}"
  project = var.gcp_project_id
}

resource "google_project_iam_member" "node-service-account-role" {
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke-autopilot-sa.email}"
  project = var.gcp_project_id
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"
  project_id                      = var.gcp_project_id
  name                            = var.cluster_name
  region                          = var.gcp_region
  zones                           = var.gcp_zones
  regional                        = true
  network                         = var.vpc_name
  subnetwork                      = var.subnet_name
  ip_range_pods                   = var.cidr_pods
  ip_range_services               = var.cidr_services
  http_load_balancing             = true
  horizontal_pod_autoscaling      = true
  enable_cost_allocation          = true
  create_service_account          = false
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = true
  service_account                 = google_service_account.gke-autopilot-sa.email
}
