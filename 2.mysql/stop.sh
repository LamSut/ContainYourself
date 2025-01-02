#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube StatefulSets
minikube kubectl -- delete statefulsets mysql

# delete Minikube services
minikube kubectl -- delete service mysql-service

# (WARNING: Those actions below will permanently delete data)

# # delete Minikube PersistentVolumeClaims
# minikube kubectl -- delete pvc shared-pvc shared-storage-mysql-0 shared-storage-mysql-1

# # remove Docker images
# docker image rm -f mysql:8.0

echo "Minikube resources deleted successfully!"