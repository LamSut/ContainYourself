# Local Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/ContactBook-FE repo
```
#### Copy Dockerfile to Vue repository
```bash
cp Dockerfile repo
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

## Run & Manage
#### Run container
```bash
docker run -d -p 443:443 vue:<tag>
```
#### List containers
```bash
docker ps
```
#### Stop container
```bash
docker stop <containerid>
```