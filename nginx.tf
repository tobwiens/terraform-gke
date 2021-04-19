//resource "kubernetes_pod" "test" {
//  metadata {
//    name = "terraform-example"
//    labels = {
//      app = "nginx"
//    }
//  }
//
//  spec {
//    container {
//      image = "nginx:1.7.9"
//      name  = "example"
//
//      env {
//        name  = "environment"
//        value = "test"
//      }
//
//      port {
//        container_port = 8080
//      }
//
//    }
//
//
//
//    dns_config {
//      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
//      searches    = ["example.com"]
//
//      option {
//        name  = "ndots"
//        value = 1
//      }
//
//      option {
//        name = "use-vc"
//      }
//    }
//
//    dns_policy = "None"
//  }
//}
//
//resource "kubernetes_service" "example" {
//  metadata {
//    name = "terraform-example"
//  }
//  spec {
//    selector = {
//      app = kubernetes_pod.test.metadata.0.labels.app
//    }
//    session_affinity = "ClientIP"
//    port {
//      port        = 8080
//      target_port = 80
//    }
//
//    type = "LoadBalancer"
//  }
//}