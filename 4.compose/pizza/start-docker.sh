#!/bin/bash

# Clone the Vue repository
echo "Cloning the PizzaGout repository..."
git clone https://github.com/LamSut/PizzaGout repo

# Change directory to the repository
cd repo || { echo "Failed to enter repo directory"; exit 1; }

# Build and start Docker Compose
echo "Building and starting Docker containers..."
docker-compose up -d

# Uncomment below lines if you want to stop and remove containers automatically
# echo "Stopping and removing Docker containers..."
# docker-compose down

echo "Setup completed!"
