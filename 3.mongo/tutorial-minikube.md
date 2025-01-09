# Minikube Docker daemon
## Prepare
#### Change the working directory to MongoDB repository
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
docker build -t mongo:v1 .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag mongo:v1 <username>/mongo  
```
#### Push image to Docker Hub
```bash
docker push <username>/mongo:v1  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f mongo-deployment.yaml
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
minikube kubectl -- port-forward svc/node-service 27017:27017 &
```
Now you can access this service from: http://localhost:27017/ 

## Destroy
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment mongo-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service mongo-service
```
#### Remove Docker image
```bash
docker image rm mongo:v1
```