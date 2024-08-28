# GCP project ID
variable "project_id" {
  description = "The GCP project ID where the Kubernetes cluster will be deployed."
  default     = "codify-playground-yannick"
}

# GCP region
variable "region" {
  description = "The GCP region where the Kubernetes cluster resources will be created."
  default     = "europe-west6" # Default region; change as needed
}

# GCP zone
variable "zone" {
  description = "The GCP zone within the selected region where the Kubernetes cluster resources will be created."
  default     = "europe-west6-a" # Default zone; change as needed
}

# Path to the service account key file
variable "service_account_key" {
  description = "Path to the service account key file with permissions to manage GCP resources."
  default     = "/Users/yannickfuchs/Documents/Work/GCPKeys/codify-playground-yannick-943c5944edd5.json" # Provide the correct path to your service account key
}

# CIDR range for the first subnet
variable "subnet1_cidr" {
  description = "The CIDR range for the first subnet."
  default     = "10.0.1.0/24"
}

# CIDR range for the second subnet
variable "subnet2_cidr" {
  description = "The CIDR range for the second subnet."
  default     = "10.0.2.0/24"
}

# Machine type for the instances
variable "machine_type" {
  description = "The machine type to be used for the Kubernetes cluster nodes."
  default     = "e2-medium" # Change the machine type if needed
}
