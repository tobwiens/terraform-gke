resource "google_compute_network" "private_network" {
  provider = google-beta

  name = "private-network"
}

resource "google_compute_global_address" "private_sql_address" {
  provider = google-beta

  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.postgresql_vpc.id

  name = "private-sql-address"
}

resource "google_service_networking_connection" "private_sql_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_sql_address.name]
}

resource "google_sql_database_instance" "postgresql_master_instance" {
  name = "postgresql_master_instance"
  database_version = "POSTGRES_11"
  project = var.project
  region = var.region

  deletion_protection = true

  depends_on = [google_service_networking_connection.private_sql_connection]

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.id
    }
  }
}

resource "google_sql_user" "postgresql_user" {
  name     = "pgadmin4-monitoring"
  instance = google_sql_database_instance.postgresql_master_instance.self_link
  host     = "pgadmin4"
  password = "secret"
}