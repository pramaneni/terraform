terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # or your desired version
    }
  }
}


provider "google" {
  project = "saitejaameda"
  region  = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-jenkins"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
    }
  }

  network_interface {
    network = "default" # Consider creating a custom VPC and subnet for production

    access_config { # Explicitly define if you need a public IP
        # nat_ip_address = google_compute_address.static.address # Example for static external IP
    }
  }
}
# resource "google_compute_address" "static" {
#     name = "static-ip-address"
#     region = "us-central1"
# }
