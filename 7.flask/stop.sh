#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployments
minikube kubectl -- delete deployment flask-deployment

# delete Minikube services
minikube kubectl -- delete service flask-service

# (WARNING: Those actions below will permanently delete data)

# # remove Docker images
# docker image rm -f flask:v1 

# # remove repository
# rm -rf repo

echo "Minikube resources deleted successfully!"