#!/bin/bash

LOG_FILE="./remove.log"
exec > >(tee "$LOG_FILE") 2>&1

REPO_DIR="$HOME/ContainYourself/compose/pizza/repo"

echo "Removing PizzaGout environment..."

if [ -d "$REPO_DIR" ]; then
  echo "Repository found. Stopping and removing containers..."
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }

  # Stop and remove containers, volumes, and networks created by docker-compose
  docker-compose down -v

  echo "Removing Docker images..."
  docker images "frontend:v1" -q | xargs -r docker rmi -f || echo "No frontend image to remove."
  docker images "backend:v1" -q | xargs -r docker rmi -f || echo "No backend image to remove."
  docker images "nginx:alpine" -q | xargs -r docker rmi -f || echo "No nginx image to remove."
  docker images "mysql:8.0" -q | xargs -r docker rmi -f || echo "No mysql image to remove."
  docker images "redis:7.0" -q | xargs -r docker rmi -f || echo "No redis image to remove."

  # Remove named volume if still exists
  docker volume rm db_data 2>/dev/null || echo "Volume db_data not found or already removed."

  # Remove custom network if still exists
  docker network rm app-network 2>/dev/null || echo "Network app-network not found or already removed."

  echo "Deleting cloned repository..."
  rm -rf "$REPO_DIR"
else
  echo "Repository not found. Skipping container and image cleanup."
fi

# Optional
echo "Cleaning up dangling Docker resources (if any)..."
docker system prune -f

echo "Removal complete."
