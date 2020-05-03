
provider "google" {
  version = "~> 3.0.0"

  credentials = file("account.json")
  project = var.project_id
}

resource "google_compute_instance" "devops-gci" {
  name         = var.gci_name
  machine_type = var.gke_machine_type
  zone         = var.location

  boot_disk {
    initialize_params {
      image = "centos-6-v20180104"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}