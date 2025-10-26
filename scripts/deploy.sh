#!/usr/bin/env bash
set -euo pipefail

MANIFEST_DIR="/opt/codedeploy/k8s"

echo "Applying manifests from $MANIFEST_DIR"
kubectl apply -f "${MANIFEST_DIR}/deployment.yaml"
kubectl apply -f "${MANIFEST_DIR}/service.yaml"

echo "Waiting for rollout..."
kubectl rollout status deploy/html-web --timeout=5m

echo "Deployment applied."