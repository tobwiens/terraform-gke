variable "name" {
  default = "terraform-gke-cluster"
}

variable "project" {
  default = "gke-sql-demo"
}

variable "region" {
  default = "europe-west4"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-1"
}