### Clone a Flask repository
```bash
git clone https://github.com/LamSut/cicd_tutorial repo
```
### Copy Dockerfile to Flask repository
```bash
cp Dockerfile repo
```
### Change the working directory to Flask repository
```bash
cd repo
```
### Build image
```bash
docker build -t flask:<tag> .
```
### List images
```bash
docker images
```
### Tag image
```bash
docker tag flask:<tag> <username>/vue:<tag> 
```
### Push image to Docker Hub
```bash
docker push <username>/flask:<tag>  
```
### Run container
```bash
docker run -d -p 5000:5000 flask:<tag>
```
### List containers
```bash
docker ps
```
### Stop container
```bash
docker stop <containerid>
```
