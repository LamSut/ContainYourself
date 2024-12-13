#### Clone a React repository
```bash
git clone https://github.com/melihs/rec-calculator repo
```
#### Copy Dockerfile to React repository
```bash
cp Dockerfile repo
```
#### Change the working directory to React repository
```bash
cd repo
```
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
#### Run container
```bash
docker run -d -p 6969:80 react:<tag>
```
#### List containers
```bash
docker ps
```
#### Stop container
```bash
docker stop <containerid>
```