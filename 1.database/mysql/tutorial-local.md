# Local Docker daemon
## Prepare
#### Change the working directory to MySQL repository
```bash
cd config
```
## Build
#### Build image
```bash
docker build -t mysql:8.0 .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag mysql:8.0 <username>/mysql  
```
#### Push image to Docker Hub
```bash
docker push <username>/mysql:8.0  
```

## Run & Manage
#### Run container
```bash
docker run --env-file .env -d -p 3308:3306 mysql:8.0
```
#### List containers
```bash
docker ps
```
#### Stop container
```bash
docker stop <containerid>
```