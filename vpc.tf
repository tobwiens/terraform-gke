resource "google_compute_network" "gke_vpc" {
  name = "gke-vpc"
  project = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name = "gke-subnet"
  ip_cidr_range = "10.0.0.0/16"
  project = var.project
  region = var.region
  network = google_compute_network.gke_vpc.id
}




