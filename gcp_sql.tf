resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name = "private-ip-address"

  project = var.project

  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.gke_vpc.id

}

resource "google_service_networking_connection" "private_sql_connection" {
  provider = google-beta


  network                 = google_compute_network.gke_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

}

resource "google_sql_database_instance" "postgresql_master_instance" {
  name = "postgresql-master-instance"
  database_version = "POSTGRES_11"
  project = var.project
  region = var.region

  deletion_protection = true

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.gke_vpc.id
    }
  }
}

resource "google_sql_user" "postgresql_user" {
  instance = google_sql_database_instance.postgresql_master_instance.name
  password = "secret"
  name     = "pgadmin4-monitoring"
}