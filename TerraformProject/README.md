# Terraform Project for Multi-Client Deployment

This project deploys a Kubernetes cluster and Odoo application for multiple clients (Netflix, Meta, Rockstar).

## Prerequisites
- Terraform
- Minikube
- kubectl

## Deployment Instructions
1. Start Minikube:
   ```bash
   minikube start --driver=docker --cpus=2 --memory=4096
   ```

2. Start Terraform:
   ```bash
   terraform init
   ```

3. Apply Terraform with the appropriate namespace

