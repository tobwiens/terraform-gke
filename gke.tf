resource "google_container_cluster" "gke_cluster" {
  name = var.name
  description = "GKE Cluster"
  project = var.project
  location = var.region


  remove_default_node_pool = false
  network = google_compute_network.gke_vpc.name
  subnetwork = google_compute_subnetwork.gke_subnet.name
  initial_node_count = var.initial_node_count

  enable_legacy_abac = true

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

//resource "google_container_node_pool" "gke_cluster_node_pool" {
//  name       = "${var.name}-node-pool"
//  project    = var.project
//  location   = var.region
//  cluster    = google_container_cluster.gke_cluster.name
//  node_count = 1
//
//
//  node_config {
//    preemptible  = true
//    machine_type = var.machine_type
//
//    metadata = {
//      disable-legacy-endpoints = "true"
//    }
//
//    oauth_scopes = [
//      "https://www.googleapis.com/auth/logging.write",
//      "https://www.googleapis.com/auth/monitoring",
//    ]
//  }
//}

