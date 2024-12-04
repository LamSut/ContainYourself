### Clone a React repository
```bash
git clone https://github.com/LamSut/ContactBook-BE repo
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
docker build -t node:<tag> .
```
### List images
```bash
docker images
```
### Tag image
```bash
docker tag node:<tag> <username>/node:<tag>
```
### Push image to Docker Hub
```bash
docker push <username>/node:<tag>
```
### Run container
```bash
docker run -d -p 6969:3000 node:<tag>
```
### List containers
```bash
docker ps
```
### Stop container
```bash
docker stop <containerid>
```