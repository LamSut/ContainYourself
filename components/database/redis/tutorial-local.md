# Local Docker daemon
## Prepare
#### Change the working directory to Redis repository
```bash
cd config
```

## Build
#### Build image
```bash
docker build -t redis:7.0 .
```
#### List images
```bash
docker images
```
#### Tag image
```bash
docker tag redis:7.0 <username>/redis  
```
#### Push image to Docker Hub
```bash
docker push <username>/redis:7.0  
```

## Run & Manage
#### Run container
```bash
docker run -d -p 6379:6379 redis:7.0
```
#### List containers
```bash
docker ps
```
#### Stop container
```bash
docker stop <containerid>
```