# Minikube Docker environment

## Prepare
#### Clone a Node repository
```bash
git clone https://github.com/LamSut/ContactBook-BE repo
```
#### Copy config files to Node repository
```bash
cp Dockerfile repo && cp node-deployment.yaml repo
```
#### Change the working directory to Node repository
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
docker build -t node:<tag> .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag node:<tag> <username>/node:<tag>
```
#### Push image to Docker Hub
```bash
docker push <username>/node:<tag>
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f node-deployment.yaml
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
minikube kubectl -- port-forward svc/node-service 6969:3000 &
```
Now you can access this service from: http://localhost:6969/  

## Destroy
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment node-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service node-service
```