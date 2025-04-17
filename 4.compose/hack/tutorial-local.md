# Local Docker environment

## Prepare
#### Clone a Vue repository
```bash
git clone https://github.com/LamSut/THS2024-77 repo
```
#### Copy Vite config to repository
```bash
cp ./config/.* ./config/* repo
```
#### Change the working directory to repository
```bash
cd repo
```

## Build & Run
#### Build and start Compose
```bash
docker-compose build
docker-compose up -d
```
#### Stop and remove Compose
```bash
docker-compose down
```
