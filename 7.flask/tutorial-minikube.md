# Local Docker environment

## Prepare
#### Clone a Flask repository
```bash
git clone https://github.com/LamSut/cicd_tutorial repo
```
#### Copy Dockerfile to Flask repository
```bash
cp Dockerfile repo && cp flask-deployment.yaml repo
```
#### Change the working directory to Flask repository
```bash
cd repo
```

## Build
#### Build image
```bash
docker build -t flask:<tag> .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag flask:<tag> <username>/flask:<tag> 
```
#### Push image to Docker Hub
```bash
docker push <username>/flask:<tag>  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f flask-deployment.yaml
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
minikube kubectl -- delete deployment flask-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service flask-service
```