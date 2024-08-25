terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = file("path_of_your_service_account.json")
}