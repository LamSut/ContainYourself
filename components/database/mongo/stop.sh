#!/bin/bash

# change the working directory 
cd config

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube StatefulSets
minikube kubectl -- delete statefulsets mongo

# delete Minikube services
minikube kubectl -- delete service mongo

# (WARNING: Those actions below will permanently delete data)

# delete Minikube PersistentVolumeClaims
minikube kubectl -- delete pvc shared-pvc shared-storage-mongo-0 shared-storage-mongo-1

# remove Docker images
docker image rm -f mongo:6.0

echo "Minikube resources deleted successfully!"