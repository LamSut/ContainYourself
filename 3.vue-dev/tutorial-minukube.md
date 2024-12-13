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
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment vue-dev-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service vue-dev-service
```