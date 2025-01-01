# Minikube Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/PizzaGout repo
```
#### Copy config files to repository
```bash
cp ./config/* repo
```
#### Change the working directory to repository
```bash
cd repo
```
#### Set Docker environment to Minikube
Configuring your Shell to use the Docker Daemon inside the Minikube VM instead of the local Docker instance:  

```bash
eval $(minikube docker-env)
```

This allows you to interact with Docker images directly in the Minikube environment for Kubernetes.

## Deploy & Orchestrate
#### Build Compose
```bash
docker-compose build
```
#### Run in Minikube
```bash
minikube kubectl -- apply -f deployment.yaml
```
#### Check Minikube pods
```bash
minikube kubectl -- get pods
```
#### Find Minikube service URL
```bash
minikube service list
```
#### Forward MySQL port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/mysql 3306:3306 &
```
Now you can access this service from: http://localhost:3306/
#### Forward Redis port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/redis 6379:6379 &
```
Now you can access this service from: http://localhost:6379/
#### Forward backend port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/backend 3000:3000 &
```
Now you can access this service from: http://localhost:3000/
#### Forward frontend port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/frontend 5173:5173 &
```
Now you can access this service from: http://localhost:5173/

## Destroy
#### Remove Port Forwarding
```bash
pkill -f "kubectl port-forward"
```
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment frontend && minikube kubectl -- delete deployment backend && minikube kubectl -- delete deployment redis
```
#### Delete Minikube StatefulSets
```bash
minikube kubectl -- delete statefulsets mysql
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service frontend && minikube kubectl -- delete service backend && minikube kubectl -- delete service redis && minikube kubectl -- delete service mysql
```
#### Delete Minikube PersistentVolumeClaims
```bash
minikube kubectl -- delete pvc shared-pvc shared-storage-mysql-0 shared-storage-mysql-1 redis-pvc
```
#### Remove Docker images
```bash
docker image rm frontend:v1 backend:v1 redis:7.0 mysql:8.0
```
