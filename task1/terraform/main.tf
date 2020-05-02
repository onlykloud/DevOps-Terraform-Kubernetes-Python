
provider "google" {
  version = "~> 3.0.0"

  credentials = file("account.json")
  location = var.location
  project = var.project
}

