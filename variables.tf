variable "project" {
  description = "The GCP project ID to deploy resources into."
  type        = string
  default     = "your-project-ID"
}

variable "region" {
  description = "The GCP region to deploy resources into."
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The GCP zone within the specified region to deploy resources into."
  type        = string
  default     = "us-east1-b"
}

variable "vm" {
  type = map(object({
    name         = string
    machine_type = string
    boot_disk = object({
      initialize_params = object({
        image = string
        size  = number
        type  = string
      })
    })
    network_interface = object({
      network = string
    })
    scheduling = object({
      preemptible        = bool
      automatic_restart  = bool
      provisioning_model = string
    })
    tags                      = list(string)
    allow_stopping_for_update = bool
    desired_status            = string
  }))
}

locals {
  firewall_config = {
    name             = "iap-access"
    network          = "default"
    allowed_protocol = "tcp"
    source_range     = "35.235.240.0/20"
    target_tags      = ["iap"]
  }
}