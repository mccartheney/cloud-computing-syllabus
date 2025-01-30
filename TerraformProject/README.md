# Terraform Kubernetes Deployment for Odoo with PostgreSQL

[![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.3.0-blue.svg)](https://terraform.io)
[![Minikube Compatible](https://img.shields.io/badge/minikube-%3E%3Dv1.30.0-orange)](https://minikube.sigs.k8s.io/)

A Terraform project to deploy Odoo with PostgreSQL on a Minikube Kubernetes cluster, configured with ingress for external access.

## Features

- 🚀 Single-command deployment
- 🔒 Automatic TLS certificate generation
- 🌐 Custom domain configuration
- 📦 Modular infrastructure components
- 🔄 Environment-aware configurations

## Prerequisites

| Component     | Version  | Installation Guide                 |
|---------------|----------|-------------------------------------|
| Terraform     | >= 1.3.0 | [terraform.io/downloads](https://www.terraform.io/downloads) |
| Minikube      | >= 1.30  | [minikube.sigs.k8s.io](https://minikube.sigs.k8s.io/docs/start/) |
| kubectl       | >= 1.26  | [kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/) |
| Docker        | >= 20.10 | [docs.docker.com/get-docker](https://docs.docker.com/get-docker/) |

## Quick Start

### 1. Initialize Minikube Cluster
```bash
minikube start
minikube addons enable ingress
```

### 2. Deploy Infrastructure

```bash
   terraform init
   terraform apply
```

Example for Netflix development environment:

```bash
   terraform apply \
      -var="client=netflix" \
      -var="domain=odoo.netflix.dev" \
      -var="environment=dev" \
      -var="namespace=netflix-dev"
```

### 3. Configure Local DNS

```bash
   echo "$(minikube ip) odoo.netflix.dev" | sudo tee -a /etc/hosts
```

### 4. Access Application

```bash
   https://odoo.netflix.dev (via browser)
```

## Customization

### Input Variables

| Variable           | Description                         | Default | Required |
|--------------------|-------------------------------------|---------|----------|
| `client`           | Client name (Netflix/Meta/Rockstar) | -       | Yes      |
| `domain`           | Base domain for ingress             | -       | Yes      |
| `environment`      | Deployment environment (dev/qa/prod)| -       | Yes      |
| `namespace`        | Kubernetes namespace                | -       | Yes      |
| `replica_number`   | Number of Odoo replicas             | `1`     | No       |

Example variable file (clients/netflix.tfvars):

```bash
client = "netflix"
domain = "odoo.netflix.dev"
environment = "dev"
namespace = "netflix-dev"
replica_number = 2
```

## Project Structure

```text
.
├── modules/              # Reusable Terraform modules
├── clients/              # Client-specific configurations
├── examples/             # Example usage patterns
├── main.tf               # Root module configuration
├── variables.tf          # Input variable definitions
├── outputs.tf            # Output value definitions
└── providers.tf          # Provider configurations
```