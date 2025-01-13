# Local Docker environment
## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/ContactBook-FE repo
```
#### Copy Dockerfile to Vue repository
```bash
cp ./config/Dockerfile repo
```
#### Change the working directory to Vue repository
```bash
cd repo
```
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

## Run & Manage
#### Run container
```bash
docker run -d -p 5173:5173 vue-dev:<tag>
```
#### List containers
```bash
docker ps
```
#### Stop container
```bash
docker stop <containerid>
```