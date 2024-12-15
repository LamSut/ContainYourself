# Local Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/PizzaGout repo
```
#### Copy config files to repository
```bash
cp docker-compose.yaml repo && cp deployment.yaml repo && cp vite.config.js repo/frontend
```
#### Change the working directory to repository
```bash
cd repo
```

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
Now you can access this service from: https://localhost:3306/
#### Forward backend port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/backend 3000:3000 &
```
Now you can access this service from: https://localhost:3000/
#### Forward frontend port on local machine to port of Minikube service
```bash
minikube kubectl -- port-forward svc/frontend 5173:5173 &
```
Now you can access this service from: https://localhost:5173/
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment <deployment name>
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service <service name>
```
