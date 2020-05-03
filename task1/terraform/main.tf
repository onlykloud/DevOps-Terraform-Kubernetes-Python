
provider "google" {
  version = "~> 3.0.0"

  credentials = file("account.json")
  project = var.project_id
}

resource "google_container_cluster" "devops_cluster" {
  name     = var.gke_name
  location = var.location
  initial_node_count = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}