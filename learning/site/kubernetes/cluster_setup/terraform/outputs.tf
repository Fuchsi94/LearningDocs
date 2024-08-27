# Output the external IP address of the Kubernetes master node
output "k8s_master_public_ip" {
  description = "The external IP address of the Kubernetes master node."
  value       = google_compute_instance.k8s-master.network_interface[0].access_config[0].nat_ip
}

# Output the external IP address of the first Kubernetes worker node
output "k8s_worker_1_public_ip" {
  description = "The external IP address of the first Kubernetes worker node."
  value       = google_compute_instance.k8s-worker-1.network_interface[0].access_config[0].nat_ip
}

# Output the external IP address of the second Kubernetes worker node
output "k8s_worker_2_public_ip" {
  description = "The external IP address of the second Kubernetes worker node."
  value       = google_compute_instance.k8s-worker-2.network_interface[0].access_config[0].nat_ip
}

# Output the name of the VPC network
output "network_name" {
  description = "The name of the VPC network created for the Kubernetes cluster."
  value       = google_compute_network.vpc_network.name
}

# Output the name of the first subnet
output "subnet1_name" {
  description = "The name of the first subnet created for the Kubernetes cluster."
  value       = google_compute_subnetwork.subnet1.name
}

# Output the name of the second subnet
output "subnet2_name" {
  description = "The name of the second subnet created for the Kubernetes cluster."
  value       = google_compute_subnetwork.subnet2.name
}
