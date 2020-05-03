
provider "google" {
  version = "~> 3.0.0"

  credentials = file("account.json")
  project = var.project_id
}

