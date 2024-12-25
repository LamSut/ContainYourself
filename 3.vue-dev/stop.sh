#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployments
minikube kubectl -- delete deployment vue-dev-deployment

# delete Minikube services
minikube kubectl -- delete service vue-dev-service

# (WARNING: Those actions below will permanently delete data)

# remove Docker images
docker image rm -f vue-dev:v1 

# # remove repository
# rm -rf repo

echo "Minikube resources deleted successfully!"