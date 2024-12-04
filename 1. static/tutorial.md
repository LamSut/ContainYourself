### Build image
```bash
docker build -t moomoo:v1 .
```
### List images
```bash
docker images
```
### Tag image
```bash
docker tag moomoo:v1 <username>/moomoo  
```
### Push image to Docker Hub
```bash
docker push <username>/moomoo:v1  
```
### Run container
```bash
docker run -d -p 6969:80 moomoo:v1
```
### List containers
```bash
docker ps
```
### Stop container
```bash
docker stop <containerid>
```