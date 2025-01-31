provider "google" {
  project = "saitejaameda"
  region  = "us-central1"
  credentials = file("gcp.json")

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
    network = "default"

    access_config {
      // Assigns a public IP
    }
  }


}

