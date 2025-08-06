#!/bin/bash

LOG_FILE="./hack.log"
exec > >(tee "$LOG_FILE") 2>&1

REPO_DIR="$HOME/ContainYourself/compose/hack/repo"

echo "Removing Ethical Hacking Training Ground..."

if [ -d "$REPO_DIR" ]; then
  echo "Repository found. Stopping and removing containers..."
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }

  # Stop and remove containers, volumes, and networks created by docker-compose
  docker-compose down -v

  echo "Removing Docker images..."
  docker images "repo_php_blue" -q | xargs -r docker rmi -f || echo "No blue image to remove."
  docker images "repo_php_green" -q | xargs -r docker rmi -f || echo "No green image to remove."
  docker images "repo_proxy" -q | xargs -r docker rmi -f || echo "No proxy image to remove."
  docker images "repo_mysql" -q | xargs -r docker rmi -f || echo "No mysql image to remove."
  docker images "repo_phpmyadmin" -q | xargs -r docker rmi -f || echo "No phpmyadmin image to remove."

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
echo "Cleaning up dangling Docker resources..."
docker system prune -f

echo "Removal complete."
