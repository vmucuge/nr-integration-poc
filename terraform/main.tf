// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("~/code/vagrant/vagrant-google/gcs-bcn-training-1-credential.json")}"
  project     = "gcs-bcn-training-1"
  region      = "us-central1"
}

data "google_client_config" "current" {}

output "project" {
  value = "${data.google_client_config.current.project}"
}

data "google_compute_zones" "available" {}

data "google_container_engine_versions" "central1b" {
  zone = "us-central1-b"
}

resource "google_container_cluster" "foo" {
  name               = "terraform-test-cluster"
  zone               = "us-central1-b"
  min_master_version     = "${data.google_container_engine_versions.central1b.latest_node_version}"
  node_version       = "${data.google_container_engine_versions.central1b.latest_node_version}"
  initial_node_count = 1

  master_auth {
    username = "vmucuge"
    password = "testpass"
  }
}

resource "google_compute_instance" "terraform_instance" {
  name         = "terraform-test-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["allow-sbt", "allow-vgm"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    os = "centos-7"
    startup-script-url = "gs://gcs-startup-scripts/provision_rpm.sh"
  }

  //metadata_startup_script = "gs://gcs-startup-scripts/provision_rpm.sh"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }
}
