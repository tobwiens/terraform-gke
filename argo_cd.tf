//terraform {
//  required_providers {
//    k8s = {
//      version = "0.9.1"
//      source  = "banzaicloud/k8s"
//    }
//  }
//}
//
//provider "k8s" {
//  config_context = "monitored-cluster"
//}
//
//module "argo_cd" {
//  source = "runoncloud/argocd/kubernetes"
//
//  namespace       = "argocd"
//  argo_cd_version = "1.8.7"
//}
