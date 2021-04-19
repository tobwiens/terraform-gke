resource "kubernetes_pod" "pgadmin4_pod" {
  metadata {
    name = "pgadmin4"
    labels = {
      app = "pgadmin4"
    }
  }

  spec {
    container {
      image = "dpage/pgadmin4:latest"
      name  = "pgadmin4-latest"

      env {
        name  = "PGADMIN_DEFAULT_EMAIL"
        value = "tobwiens@gmail.com"
      }

      env {
        name  = "PGADMIN_DEFAULT_PASSWORD"
        value = "secret"
      }

      port {
        container_port = 80
      }

      liveness_probe {
        http_get {
          path = ""
          port = 80
        }

        initial_delay_seconds = 30
        period_seconds        = 5
      }
    }

    dns_config {
      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
      searches    = ["example.com"]

      option {
        name  = "ndots"
        value = 1
      }

      option {
        name = "use-vc"
      }
    }

    dns_policy = "None"
  }
}

resource "kubernetes_service" "pgadmin4_service" {
  metadata {
    name = "pgadmin4-service"
  }
  spec {
    selector = {
      app = kubernetes_pod.pgadmin4_pod.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}