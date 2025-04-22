resource "google_container_cluster" "x" {
  name                     = "${var.alias}-cluster1"
  location                 = "europe-west1"
  network                  = var.network
  subnetwork               = var.subnets[0]
  remove_default_node_pool = false
  initial_node_count       = 3
  networking_mode          = "VPC_NATIVE"
  provider                 = google-beta

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly"
    ]

    service_account = google_service_account.x.email
    machine_type = "n2-standard-2"
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}