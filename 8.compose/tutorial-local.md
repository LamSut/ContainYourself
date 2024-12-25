# Local Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/PizzaGout repo
```
#### Copy Vite config to repository
```bash
cp vite.config.js repo/frontend
```
#### Change the working directory to repository
```bash
cd repo
```

## Build & Run
#### Build and start Compose
```bash
docker-compose up -d
```
#### Stop and remove Compose
```bash
docker-compose down
```
