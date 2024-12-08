### Clone a Vue repository
```bash
git clone https://github.com/LamSut/PizzaGout repo
```
### Copy Docker Compose file to repository
```bash
cp docker-compose.yaml repo
```
### Copy SQL file to repository
```bash
cp pizza.sql repo
```
### Replace Vite proxy config
```bash
cp vite.config.js repo/frontend
```
### Change the working directory to repository
```bash
cd repo
```
### Build compose
```bash
docker-compose -f docker-compose.yaml up -d --build
```
### Stop compose
```bash
docker stop $(docker ps -aq)
```
### Remove compose
```bash
docker rm $(docker ps -aq)
```
