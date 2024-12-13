# Local Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/PizzaGout repo
```
#### Copy Docker Compose file to repository
```bash
cp docker-compose.yaml repo
```
#### Copy SQL file to repository
```bash
cp pizza.sql repo
```
#### Replace Vite proxy config
```bash
cp vite.config.js repo/frontend
```
#### Change the working directory to repository
```bash
cd repo
```

## Build
#### Build and start Compose
```bash
docker-compose up -d
```
#### Stop and remove Compose
```bash
docker-compose down
```
