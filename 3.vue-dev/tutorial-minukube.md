# Minikube Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/ContactBook-FE repo
```
#### Copy Dockerfile to Vue repository
```bash
cp Dockerfile repo && cp vue-dev-deployment.yaml repo
```
#### Change the working directory to Vue repository
```bash
cd repo
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
docker build -t vue-dev:<tag> .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag vue-dev:<tag> <username>/vue-dev:<tag> 
```
#### Push image to Docker Hub
```bash
docker push <username>/vue-dev:<tag>  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f vue-dev-deployment.yaml
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
minikube kubectl -- delete deployment vue-dev-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service vue-dev-service
```