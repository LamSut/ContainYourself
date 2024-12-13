# Local Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/ContactBook-FE repo
```
#### Copy Dockerfile & Nginx config file to Vue repository
```bash
cp Dockerfile repo && cp nginx.conf repo && cp vue-deployment.yaml repo
```
#### Change the working directory to Vue repository
```bash
cd repo
```

## Build
#### Build image
```bash
docker build -t vue:<tag> .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag vue:<tag> <username>/vue:<tag> 
```
#### Push image to Docker Hub
```bash
docker push <username>/vue:<tag>  
```

## Deploy & Orchestrate
#### Run in Minikube
```bash
minikube kubectl -- apply -f vue-deployment.yaml
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
minikube kubectl -- delete deployment vue-deployment
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service vue-service
```