### Clone a Vue repository
```bash
git clone https://github.com/LamSut/PizzaGout repo
```
### Copy Dockerfile to Vue repository
```bash
cp docker-compose.yaml repo
```
### Change the working directory to Vue repository
```bash
cd repo
```
### Build compose
```bash
docker-compose -f docker-compose.yaml up -d --build
```
