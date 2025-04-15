#!/bin/bash

REPO_DIR="$HOME/containers/4.compose/pizza/repo"

echo "Cloning the PizzaGout repository..."
git clone https://github.com/LamSut/PizzaGout.git "$REPO_DIR"

cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }

echo "Building and starting Docker containers..."
docker-compose build
docker-compose up -d

echo "Setup completed!"
