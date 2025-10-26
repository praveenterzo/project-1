#!/usr/bin/env bash
set -euo pipefail

# Ensure AWS CLI & kubectl exist (install if missing)
if ! command -v aws >/dev/null 2>&1; then
  echo "Installing AWS CLI v2..."
  yum install -y unzip >/dev/null 2>&1 || true
  curl -sSLo /tmp/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
  unzip -q /tmp/awscliv2.zip -d /tmp
  /tmp/aws/install
fi

if ! command -v kubectl >/dev/null 2>&1; then
  echo "Installing kubectl..."
  curl -sSLo /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.29.0/2024-06-10/bin/linux/amd64/kubectl
  chmod +x /usr/local/bin/kubectl
fi

# Configure kubeconfig for the cluster (set your region & cluster)
: "${AWS_REGION:=us-east-1}"
: "${EKS_CLUSTER:=html-eks}"

aws eks update-kubeconfig --region "$AWS_REGION" --name "$EKS_CLUSTER"

echo "Kube context:"
kubectl config current-context
kubectl get nodes -o wide
