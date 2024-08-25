resource "google_compute_instance" "vm" {
  for_each     = var.vm
  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = each.value.boot_disk.initialize_params.image
      size  = each.value.boot_disk.initialize_params.size
      type  = each.value.boot_disk.initialize_params.type
    }
  }

  # Note: The VM created with this configuration will not have an external IP address.
  network_interface {
    network = each.value.network_interface.network
  }

  scheduling {
    preemptible        = each.value.scheduling.preemptible
    automatic_restart  = each.value.scheduling.automatic_restart
    provisioning_model = each.value.scheduling.provisioning_model
  }

  allow_stopping_for_update = each.value.allow_stopping_for_update
  desired_status            = each.value.desired_status
  tags                      = each.value.tags
}