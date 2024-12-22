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
docker build -t moomoo:v1 .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag moomoo:v1 <username>/moomoo  
```
#### Push image to Docker Hub
```bash
docker push <username>/moomoo:v1  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f moomoo-deployment.yaml
```
#### Check Minikube pods
```bash
minikube kubectl -- get pods
```
#### Find Minikube service URL
```bash
minikube service list
```

## Destroy
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment moomoo-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service moomoo-service
```