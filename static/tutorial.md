### Build Image
```bash
docker build -t moomoo:v1 .
```
### List Images
```bash
docker images
```
### Tag Image
```bash
docker tag moomoo:v1 lamsut007/moomoo  
```
### Push Image To Docker Hub
```bash
docker push lamsut007/moomoo:v1  
```
### Run Container
```bash
docker run -d -p 6969:80 moomoo:v1
```
### List Containers
```bash
docker ps
```
### Stop Container
```bash
docker stop <containerid>
```