#!/bin/bash

LOG_FILE="./pizza.log"
exec > >(tee "$LOG_FILE") 2>&1

REPO_DIR="$HOME/containers/4.compose/pizza/repo"
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

# Get public IP from ifconfig.me
PUBLIC_IP=$(curl -s ifconfig.me)
echo "Public IP: $PUBLIC_IP"

# Update SWAGGER_HOST
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
