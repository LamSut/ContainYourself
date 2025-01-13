# Minikube Docker daemon
## Prepare
#### Change the working directory to Redis repository
```bash
cd config
```
#### Set Docker environment to Minikube
Configuring your Shell to use the Docker Daemon inside the Minikube VM instead of the local Docker instance:  

```bash
eval $(minikube docker-env)
```

This allows you to interact with Docker images directly in the Minikube environment for Kubernetes.

## Build
#### Build image
```bash
docker build -t redis:7.0 .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag redis:7.0 <username>/redis  
```
#### Push image to Docker Hub
```bash
docker push <username>/redis:7.0  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f redis-deployment.yaml
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
minikube kubectl -- port-forward svc/node-service 6379:6379 &
```
Now you can access this service from: http://localhost:6379/ 

## Destroy
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment redis-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service redis-service
```
#### Remove Docker image
```bash
docker image rm redis:7.0
```