#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployment
minikube kubectl -- delete deployment moomoo-deployment

# delete Minikube services
minikube kubectl -- delete service moomoo-service

# (WARNING: Those actions below will permanently delete data)

# # remove Docker images
# docker image rm -f moomoo:v1

echo "Minikube resources deleted successfully!"