#!/bin/bash

# set up Prometheus and Grafana for Minikube
# prerequisite: Helm installed
echo "Starting Prometheus and Grafana Setup..."

# change Docker daemon to Minikube
eval $(minikube docker-env)

# monitoring namespace
NAMESPACE="monitoring"
echo "Creating namespace: $NAMESPACE"
minikube kubectl -- create namespace $NAMESPACE || echo "Namespace $NAMESPACE already exists"

# install Prometheus
echo "Installing Prometheus using Helm..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus \
  --namespace $NAMESPACE \
  --set alertmanager.persistentVolume.enabled=false \
  --set server.persistentVolume.enabled=false

if [ $? -eq 0 ]; then
  echo "Prometheus installed successfully."
else
  echo "Failed to install Prometheus."
  exit 1
fi

# install Grafana
echo "Installing Grafana using Helm..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana \
  --namespace $NAMESPACE \
  --set persistence.enabled=false \
  --set adminPassword=admin

if [ $? -eq 0 ]; then
  echo "Grafana installed successfully."
else
  echo "Failed to install Grafana."
  exit 1
fi

sleep 10

# ensure monitoring pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all -n monitoring --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# expose Prometheus and Grafana
echo "Exposing Prometheus Service..."
minikube kubectl -- port-forward -n $NAMESPACE svc/prometheus-server 9090:80 &

echo "Exposing Grafana Service..."
minikube kubectl -- port-forward -n $NAMESPACE svc/grafana 3030:80 &

# finish
echo "Setup Complete!"
echo "Prometheus is available at: http://localhost:9090"
echo "Grafana is available at: http://localhost:3030"
echo "Grafana login credentials: Username: admin, Password: admin"

exit 0
