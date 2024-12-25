#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# build Docker images
echo "Building Docker image..."
docker build -t moomoo:v1 . || { echo "Failed to build Docker image"; exit 1; }

# deploy with Minikube
echo "Applying Kubernetes deployment..."
minikube kubectl -- apply -f moomoo-deployment.yaml || { echo "Failed to apply Kubernetes deployment"; exit 1; }

# ensure pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# forward port
echo "Forwarding port..."
minikube kubectl -- port-forward svc/moomoo-service 6969:80 &

# finish
echo "Setup complete! Services can be accessed via the following URLs:"
echo "- MySQL: http://localhost:6969"
