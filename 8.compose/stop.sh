#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployments
minikube kubectl -- delete deployment --all

# delete Minikube StatefulSets
minikube kubectl -- delete statefulsets --all

# delete Minikube services
minikube kubectl -- delete service frontend
minikube kubectl -- delete service backend
minikube kubectl -- delete service mysql

# delete Minikube PersistentVolumeClaims
minikube kubectl -- delete pvc --all

# remove Docker images
docker image rm frontend:v1 backend:v1 mysql:8.0

echo "Minikube resources deleted successfully."