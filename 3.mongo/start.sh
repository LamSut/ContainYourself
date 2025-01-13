#!/bin/bash

# change the working directory 
cd config

# change Docker daemon to Minikube
eval $(minikube docker-env)

# build Docker images
echo "Building Docker images..."
docker-compose build || { echo "Failed to build with Docker Compose"; exit 1; }

# deploy with Minikube
echo "Applying Kubernetes deployment..."
minikube kubectl -- apply -f mongo-deployment.yaml || { echo "Failed to apply Redis deployment"; exit 1; }

# ensure pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# forward port
echo "Forwarding MongoDB port..."
minikube kubectl -- port-forward svc/mongo 27017:27017 &

# finish
echo "Setup complete! Services can be accessed via the following URLs:"
echo "- MongoDB: http://localhost:27017"
