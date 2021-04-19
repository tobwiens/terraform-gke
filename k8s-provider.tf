data "google_client_config" "provider" {}



provider "kubernetes" {

  host = google_container_cluster.gke_cluster.endpoint


  client_certificate =  base64decode(google_container_cluster.gke_cluster.master_auth.0.client_certificate)
  client_key =  base64decode(google_container_cluster.gke_cluster.master_auth.0.client_key)
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
}

//resource "kubernetes_cluster_role" "client_role" {
//  metadata {
//    name = "terraform-example"
//  }
//
//  rule {
//    api_groups = [""]
//    resources  = ["namespaces", "pods"]
//    verbs      = ["get", "list", "watch"]
//  }
//}