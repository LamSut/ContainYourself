# Minikube Docker environment

## Prepare
#### Clone a React repository
```bash
git clone https://github.com/melihs/rec-calculator repo
```
#### Copy Dockerfile to React repository
```bash
cp ./config/* repo
```
#### Change the working directory to React repository
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
docker build -t react:<tag> .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag react:<tag> <username>/react:<tag> 
```
#### Push image to Docker Hub
```bash
docker push <username>/react:<tag>  
```

# Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f react-deployment.yaml
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
minikube kubectl -- delete deployment react-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service react-service
```
```