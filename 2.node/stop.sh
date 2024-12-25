#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployments
minikube kubectl -- delete deployment node-deployment

# delete Minikube services
minikube kubectl -- delete service node-service

# (WARNING: Those actions below will permanently delete data)

# # remove Docker images
# docker image rm -f node:v1 

echo "Minikube resources deleted successfully!"