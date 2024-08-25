# Secure GCP VM Access with Identity-Aware Proxy

## Overview

This repository provides a Terraform-based solution for configuring secure access to Google Cloud Platform (GCP) virtual machines using Identity-Aware Proxy (IAP). It demonstrates how to set up IAP to securely connect to VMs via SSH without exposing SSH ports to the public internet.

## Prerequisites

Before you start, ensure you have the following:

- A Google Cloud account with a project created.
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install-sdk) installed on your computer.
- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- Identity-Aware Proxy API enabled in your GCP project.
- Ingress TCP traffic allowed from the IP range `35.235.240.0/20`.

## Getting Started

Follow these steps to configure secure access to your VM:

```bash
# 1. Clone the Repository
git clone https://github.com/your-username/your-repository.git
cd your-repository

# 2. Configure Google Cloud SDK
gcloud init

# 3. Configure Terraform
# - Update the `terraform.tfvars` file with your GCP project details.
# - Set your project ID and service account file in the provider configuration.

# Example provider configuration in `provider.tf`:

provider "google" {
  project     = "<YOUR_PROJECT_ID>"
  region      = "your-region"
  credentials = file("<YOUR_SERVICE_ACCOUNT_FILE>.json")
}

# 4. Initialize Terraform
terraform init

# 5. Apply Terraform Configuration
terraform apply

# 6. Connect to the VM
gcloud compute ssh [INSTANCE_NAME] --tunnel-through-iap
```

## Example terraform.tfvars Configuration

```bash

vm = {
  vm_01 = {
    name         = "iap-access"
    machine_type = "custom-1-2048"
    boot_disk = {
      initialize_params = {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
        size  = 15
        type  = "pd-standard"
      }
    }
    network_interface = {
      network = "default"
    }
    scheduling = {
      preemptible        = true
      automatic_restart  = false
      provisioning_model = "SPOT"
    }
    tags                      = ["iap"]
    allow_stopping_for_update = true
    desired_status            = "RUNNING"
  }
}

```

## Notes
- For more details on Identity-Aware Proxy, visit the official documentation.
- Ensure you have the appropriate IAM roles assigned to access the resources.

- IP Range for Firewall Policy: The IP range 35.235.240.0/20 used in the firewall policy is designated for IAP's backend services. This range is required to allow ingress TCP traffic through IAP. It ensures that traffic originating from Google's IAP infrastructure is permitted to reach your VMs. For further details on IP ranges used by IAP, refer to the Google Cloud documentation.