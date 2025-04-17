#!/bin/bash

REPO_DIR="$HOME/containers/4.compose/hack/repo"

echo "Cloning the Ethical Hacking Trainning Ground repository..."
git clone https://github.com/LamSut/THS2024-77.git "$REPO_DIR"

cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }

echo "Copying config files into repo..."
cp ../config/.* ../config/* "$REPO_DIR"

echo "Building and starting Docker containers..."
docker-compose down
docker-compose build --no-cache php
docker-compose up -d