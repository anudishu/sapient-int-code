// Configure the Google Cloud provider
provider "google" {
  credentials = file("${path.module}/prod-svc-creds2.json")
  project     = var.gcp_project
  region      = var.region
}

resource "google_compute_project_metadata_item" "ssh-keys" {
  project = var.gcp_project
  key     = "ssh-keys"
  value   = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
}

// Create VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
}

// Create Subnet
resource "google_compute_subnetwork" "app" {
  name          = "${var.project_name}-app-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = "${var.project_name}-vpc"
  depends_on    = [google_compute_network.vpc]
  region        = var.region
}

// VPC firewall configuration
resource "google_compute_firewall" "firewall" {
  name    = "${var.project_name}-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-9000"]
  }

  source_tags = ["web"]

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "webservers" {
  count        = length(var.webservers)
  name         = "${var.project_name}-web-${count.index}"
  machine_type = var.webservers[count.index].type
  zone         = var.zone

  tags = ["http-server", "https-server", var.webservers[count.index].name]

  service_account {
    scopes = var.scopes_default_web
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.app.self_link
    access_config {
      // Ephemeral IP
    }
  }

  boot_disk {
    initialize_params {
      image = var.webservers[count.index].image
    }
  }
}

output "webserver_ip_addresses" {
  value = {
    for webserver in google_compute_instance.webservers :
    webserver.instance_id => webserver.network_interface.0.access_config.0.nat_ip
  }
}

