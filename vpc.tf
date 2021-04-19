resource "google_compute_network" "gke_vpc" {
  name = "gke-vpc"
  project = var.project
  auto_create_subnetworks = false
}


resource "google_compute_network" "postgresql_vpc" {
  name = "postgresql-vpc"
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


resource "google_compute_subnetwork" "postgresql_subnet" {
  name = "postgres-subnet"
  ip_cidr_range = "10.240.0.0/16"
  project = var.project
  region = var.region
  network = google_compute_network.postgresql_vpc.id
}


//resource "google_compute_network_peering" "peering1" {
//  name = "gke-sql-peering"
//  network = google_compute_network.gke_vpc.id
//  peer_network = google_compute_network.postgresql_vpc.id
//}
//
//
//resource "google_compute_network_peering" "peering2" {
//  name = "sql-gke-peering"
//  network = google_compute_network.postgresql_vpc.id
//  peer_network = google_compute_network.gke_vpc.id
//}