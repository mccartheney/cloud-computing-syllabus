provider "kubernetes" {
  config_path = "~/.kube/config"
}



resource "kubernetes_namespace" "client_namespace" {
  metadata {
    name = "${var.client}-${var.environment}"
  }
}


variable "minikube_driver" {
  default = "docker"
}

variable "minikube_cpus" {
  default = 2
}

variable "minikube_memory" {
  default = 4096
}

resource "null_resource" "minikube_profile" {
  provisioner "local-exec" {
    command = <<EOT
    if ! minikube profile list | grep -q "${var.client}"; then
      minikube start --profile=${var.client} \
        --driver=${var.minikube_driver} \
        --cpus=${var.minikube_cpus} \
        --memory=${var.minikube_memory}
    else
      echo "Minikube profile '${var.client}' already exists."
    fi
    EOT
  }
}

module "kubernetes_cluster" {
  source     = "./modules/kubernetes-cluster"
  namespace  = kubernetes_namespace.client_namespace.metadata[0].name
}

module "postgresql" {
  source     = "./modules/postgresql"
  namespace  = kubernetes_namespace.client_namespace.metadata[0].name
}

module "odoo_deployment" {
  source       = "./modules/odoo-deployment"
  namespace    = kubernetes_namespace.client_namespace.metadata[0].name
  replica_number = var.replica_number
}

module "ingress" {
  source     = "./modules/ingress"
  domain = var.domain
  namespace  = kubernetes_namespace.client_namespace.metadata[0].name
}

