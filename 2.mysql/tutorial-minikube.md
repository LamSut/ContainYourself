# Minikube Docker daemon
## Prepare
#### Set Docker environment to Minikube
Configuring your Shell to use the Docker Daemon inside the Minikube VM instead of the local Docker instance:  

```bash
eval $(minikube docker-env)
```

This allows you to interact with Docker images directly in the Minikube environment for Kubernetes.

## Build
#### Build image
```bash
docker build -t mysql:8.0 .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag mysql:8.0 <username>/mysql  
```
#### Push image to Docker Hub
```bash
docker push <username>/mysql:8.0  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f mysql-deployment.yaml
```
#### Check Minikube pods
```bash
minikube kubectl -- get pods
```
#### Find Minikube service URL
```bash
minikube service list
```
#### Forward port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/node-service 3308:3306 &
```
Now you can access this service from: http://localhost:3308/ 

## Destroy
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment mysql-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service mysql-service
```
#### Remove Docker image
```bash
docker image rm mysql:8.0
```