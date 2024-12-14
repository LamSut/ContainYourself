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
#### Delete Minikube deployment
```bash
minikube kubectl -- delete deployment <deployment name>
```
#### Delete Minikube service
```bash
minikube kubectl -- delete service <service name>
```
