#!/bin/bash

LOG_FILE="./pizza.log"
exec > >(tee "$LOG_FILE") 2>&1

REPO_DIR="$HOME/ContainYourself/compose/pizza/repo"
REPO_URL="https://github.com/LamSut/PizzaGout.git"
COMPOSE_FILE="$REPO_DIR/docker-compose.yaml"

echo "Preparing PizzaGout repository..."

if [ -d "$REPO_DIR" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }
  git pull
else
  echo "Cloning the repository..."
  git clone "$REPO_URL" "$REPO_DIR"
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }
fi

# Copy config files into repo
echo "Copying config files into repo..."
cp -r ../config/. "$REPO_DIR"

# Generate SSL certificates
echo "Generating SSL certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./ssl/server.key -out ./ssl/server.crt \
  -subj "/C=VN/ST=CT/L=NK/O=CTU/OU=CICT/CN=w0rm.org" \
  -addext "basicConstraints=CA:FALSE"

# Get public IP
PUBLIC_IP=$(curl -s ifconfig.me)
echo "Public IP: $PUBLIC_IP"

# Comment this for local
sed -i "s/localhost/$PUBLIC_IP/g" ./nginx.conf
if grep -q "SWAGGER_HOST=" "$COMPOSE_FILE"; then
  sed -i "s/SWAGGER_HOST=.*/SWAGGER_HOST=$PUBLIC_IP/" "$COMPOSE_FILE"
else
  echo "SWAGGER_HOST=$PUBLIC_IP" >> "$COMPOSE_FILE"
fi

echo "Building and starting Docker containers..."
docker-compose down
docker-compose build
docker-compose up -d

echo "Setup completed!"
