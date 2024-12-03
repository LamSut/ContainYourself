### Clone a React repository
```bash
git clone https://github.com/melihs/rec-calculator repo
```
### Copy Dockerfile to React repository
```bash
cp Dockerfile repo
```
### Change the working directory to React repository
```bash
cd repo
```
### Build image
```bash
docker build -t react:v1 .
```
### List images
```bash
docker images
```
### Tag image
```bash
docker tag react:v1 <username>/react:v1 
```
### Push image to Docker Hub
```bash
docker push <username>/react:v1  
```
### Run container
```bash
docker run -d -p 6969:80 react:v1
```
### List containers
```bash
docker ps
```
### Stop container
```bash
docker stop <containerid>
```