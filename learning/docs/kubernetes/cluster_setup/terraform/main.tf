provider "google" {
  credentials = file(var.service_account_key) # Path to the service account key file for GCP
  project     = var.project_id                # GCP project ID
  region      = var.region                    # GCP region where resources will be created
}

# Define the VPC network for Kubernetes
resource "google_compute_network" "vpc_network" {
  name                    = "k8s-network" # Name of the VPC network
  auto_create_subnetworks = false         # Disable automatic subnet creation
}

# Define the first subnet in the VPC
resource "google_compute_subnetwork" "subnet1" {
  name          = "k8s-subnet-1"                               # Name of the subnet
  ip_cidr_range = var.subnet1_cidr                             # CIDR range for the subnet
  region        = var.region                                   # GCP region for the subnet
  network       = google_compute_network.vpc_network.self_link # Link to the parent VPC network
}

# Define the second subnet in the VPC
resource "google_compute_subnetwork" "subnet2" {
  name          = "k8s-subnet-2"                               # Name of the subnet
  ip_cidr_range = var.subnet2_cidr                             # CIDR range for the subnet
  region        = var.region                                   # GCP region for the subnet
  network       = google_compute_network.vpc_network.self_link # Link to the parent VPC network
}

# Firewall rule to allow traffic to the Kubernetes API server
resource "google_compute_firewall" "allow_k8s_api_server" {
  name    = "k8s-allow-k8s-api-server"              # Name of the firewall rule
  network = google_compute_network.vpc_network.name # VPC network the rule applies to

  allow {
    protocol = "tcp"    # Allow TCP protocol
    ports    = ["6443"] # Port for Kubernetes API server
  }

  source_ranges = ["0.0.0.0/0"]  # Open to the internet; restrict in production
  target_tags   = ["k8s-master"] # Target only the master node
}

# Firewall rule to allow internal communication between nodes
resource "google_compute_firewall" "allow_internal" {
  name    = "k8s-allow-internal"                    # Name of the firewall rule
  network = google_compute_network.vpc_network.name # VPC network the rule applies to

  allow {
    protocol = "tcp"       # Allow TCP protocol
    ports    = ["0-65535"] # Allow all TCP ports
  }

  allow {
    protocol = "udp"       # Allow UDP protocol
    ports    = ["0-65535"] # Allow all UDP ports
  }

  allow {
    protocol = "icmp" # Allow ICMP protocol
  }

  source_ranges = ["10.0.0.0/16"]              # Restrict to the VPC's CIDR range
  target_tags   = ["k8s-master", "k8s-worker"] # Target both master and worker nodes
}

# Firewall rule to allow SSH access
resource "google_compute_firewall" "allow_ssh" {
  name    = "k8s-allow-ssh"                         # Name of the firewall rule
  network = google_compute_network.vpc_network.name # VPC network the rule applies to

  allow {
    protocol = "tcp"  # Allow TCP protocol
    ports    = ["22"] # Port for SSH
  }

  source_ranges = ["0.0.0.0/0"]                # Open to the internet; restrict in production
  target_tags   = ["k8s-master", "k8s-worker"] # Target both master and worker nodes
}

# Define the Kubernetes master node
resource "google_compute_instance" "k8s-master" {
  name         = "k8s-master"     # Name of the instance
  machine_type = var.machine_type # Machine type for the instance
  zone         = var.zone         # GCP zone for the instance

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # Operating system image for the instance
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet1.self_link # Subnet for the instance

    access_config {
      # Ephemeral IP
    }
  }

  tags = ["k8s-master"] # Tags for identifying the instance

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"] # Scopes for the service account
  }
}

# Define the first Kubernetes worker node
resource "google_compute_instance" "k8s-worker-1" {
  name         = "k8s-worker-1"   # Name of the instance
  machine_type = var.machine_type # Machine type for the instance
  zone         = var.zone         # GCP zone for the instance

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # Operating system image for the instance
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.self_link # Subnet for the instance

    access_config {
      # Ephemeral IP
    }
  }

  tags = ["k8s-worker"] # Tags for identifying the instance

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"] # Scopes for the service account
  }
}

# Define the second Kubernetes worker node
resource "google_compute_instance" "k8s-worker-2" {
  name         = "k8s-worker-2"   # Name of the instance
  machine_type = var.machine_type # Machine type for the instance
  zone         = var.zone         # GCP zone for the instance

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # Operating system image for the instance
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.self_link # Subnet for the instance

    access_config {
      # Ephemeral IP
    }
  }

  tags = ["k8s-worker"] # Tags for identifying the instance

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"] # Scopes for the service account
  }
}

# Output the external IP addresses of the instances
output "instance_ips" {
  value = {
    k8s_master  = google_compute_instance.k8s-master.network_interface.0.access_config.0.nat_ip   # External IP of master node
    k8s_worker1 = google_compute_instance.k8s-worker-1.network_interface.0.access_config.0.nat_ip # External IP of first worker node
    k8s_worker2 = google_compute_instance.k8s-worker-2.network_interface.0.access_config.0.nat_ip # External IP of second worker node
  }
}
