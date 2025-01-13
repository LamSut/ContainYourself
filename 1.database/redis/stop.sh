#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployments
minikube kubectl -- delete deployment redis

# delete Minikube services
minikube kubectl -- delete service redis

# (WARNING: Those actions below will permanently delete data)

# # delete Minikube PersistentVolumeClaims
# minikube kubectl -- delete pvc redis-pvc

# # remove Docker images
# docker image rm -f redis:7.0

echo "Minikube resources deleted successfully!"