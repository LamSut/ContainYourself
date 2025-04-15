#!/bin/bash

REPO_PATH="/home/{{ ansible_user }}/containers/4.compose/pizza/repo"

echo "Cloning the PizzaGout repository..."
git clone https://github.com/LamSut/PizzaGout.git "$REPO_PATH"

cd "$REPO_PATH" || { echo "Failed to enter repo directory"; exit 1; }

echo "Building and starting Docker containers..."
docker-compose build
docker-compose up -d

echo "Setup completed!"
