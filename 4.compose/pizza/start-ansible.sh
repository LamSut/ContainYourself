#!/bin/bash

REPO_DIR="$HOME/containers/4.compose/pizza/repo"
COMPOSE_FILE="$REPO_DIR/docker-compose.yaml"

echo "Cloning the PizzaGout repository..."
git clone https://github.com/LamSut/PizzaGout.git "$REPO_DIR"

cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }

# Get public IP from ifconfig.me
PUBLIC_IP=$(curl -s ifconfig.me)
echo "Public IP: $PUBLIC_IP"

# Replace SWAGGER_HOST value in docker-compose.yaml
sed -i "s/SWAGGER_HOST=.*/SWAGGER_HOST=$PUBLIC_IP/" "$COMPOSE_FILE"

echo "Building and starting Docker containers..."
docker-compose build
docker-compose up -d

echo "Setup completed!"
