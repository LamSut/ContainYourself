# Minikube Docker environment

## Prepare
#### Clone a React repository
```bash
git clone https://github.com/melihs/rec-calculator repo
```
#### Copy Dockerfile to React repository
```bash
cp Dockerfile repo && cp react-deployment.yaml repo
```
#### Change the working directory to React repository
```bash
cd repo
```

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
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment react-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service react-service
```
```