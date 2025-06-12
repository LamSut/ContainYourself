#!/bin/bash

REPO_DIR="$HOME/containers/4.compose/hack/repo"
REPO_URL="https://github.com/LamSut/THS2024-77.git"

echo "Preparing Ethical Hacking Training Ground repository..."

if [ -d "$REPO_DIR/.git" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }
  git pull
else
  echo "Cloning the repository..."
  git clone "$REPO_URL" "$REPO_DIR"
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }
fi

echo "Copying config files into repo..."
cp -r ../config/. "$REPO_DIR"

echo "Building and starting Docker containers..."
docker-compose down
docker-compose build --no-cache php
docker-compose up -d
