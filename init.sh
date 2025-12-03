#!/bin/bash

set -e

echo "=========================================="
echo "DevOps Troubleshooting Interview Setup"
echo "=========================================="
echo ""

# Check if k3d is installed
if ! command -v k3d &> /dev/null; then
    echo "Error: k3d is not installed. Please install it first."
    echo "Visit: https://k3d.io/v5.6.0/#installation"
    exit 1
fi

# Delete existing cluster if it exists
if k3d cluster list | grep -q devops-interview; then
    echo "Removing existing cluster..."
    k3d cluster delete devops-interview
fi

echo "Creating k3d cluster (without traefik)..."
k3d cluster create devops-interview \
  --servers 1 \
  --agents 2 \
  --k3s-arg "--disable=traefik@server:0" \
  --port "8080:80@loadbalancer" \
  --port "8443:443@loadbalancer" \
  --wait

echo ""
echo "Waiting for cluster to be ready..."
sleep 10

echo ""
echo "Installing nginx ingress controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml

echo ""
echo "Waiting for nginx ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# Apply taint to one of the worker nodes
echo ""
echo "Configuring cluster nodes..."
sleep 5
NODE=$(kubectl get nodes --no-headers -o custom-columns=":metadata.name" | grep agent | head -n 1)
kubectl taint nodes $NODE workload=special:NoSchedule

echo ""
echo "=========================================="
echo "Cluster Setup Complete!"
echo "=========================================="
echo ""
kubectl get nodes
echo ""
echo "=========================================="
echo "INTERVIEW TASK"
echo "=========================================="
echo ""
echo "There are MULTIPLE issues in the deployment manifests."
echo "Your goal: Troubleshoot and fix ALL issues to get the"
echo "application fully accessible via ingress."
echo ""
echo "To start, deploy the application:"
echo "  kubectl apply -f manifests/"
echo ""
echo "Expected outcome:"
echo "  - All pods should be Running and Ready"
echo "  - Application accessible via: http://localhost:8080"
echo ""
echo "Good luck!"
echo "=========================================="
