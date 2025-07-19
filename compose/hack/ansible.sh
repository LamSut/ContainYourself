#!/bin/bash

LOG_FILE="./hack.log"
exec > >(tee "$LOG_FILE") 2>&1

REPO_DIR="$HOME/ContainYourself/compose/hack/repo"
REPO_URL="https://github.com/LamSut/W0rm.git"
ACTIVE_COLOR_FILE="./active_color.txt"

echo "Preparing Ethical Hacking Training Ground repository..."

if [ -d "$REPO_DIR" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }
  git pull
else
  echo "Cloning the repository..."
  git clone "$REPO_URL" "$REPO_DIR"
  cd "$REPO_DIR" || { echo "Failed to enter repo directory"; exit 1; }
fi

# Deployment for the first time
if [ ! -f "$ACTIVE_COLOR_FILE" ]; then
  echo "Copying config files into repo..."
  cp -r ../config/. "$REPO_DIR"
  
  echo "Generating SSL certificates..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ./ssl/server.key -out ./ssl/server.crt \
    -subj "/C=VN/ST=CT/L=NK/O=CTU/OU=CICT/CN=localhost" \
    -addext "basicConstraints=CA:FALSE"

  # Comment this for local
  echo "Getting the Public IP of the current EC2 instance"
  PUBLIC_IP=$(curl -s https://api.ipify.org)
  sed -i "s/localhost/$PUBLIC_IP/g" ./php_blue.conf ./php_green.conf

  echo "Building and starting services..."
  echo "blue" > "$ACTIVE_COLOR_FILE"

  # Setup proxy to use blue
  cp ./php_blue.conf ./php_active.conf

  # Build all except php_green
  docker-compose build proxy php_blue mysql phpmyadmin

  # Start required containers
  docker-compose up -d proxy php_blue mysql phpmyadmin

  wait_for_healthy() {
    local container=$1
    for i in {1..20}; do
      STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$container" 2>/dev/null)
      if [ "$STATUS" == "healthy" ]; then
        echo "$container is healthy."
        return
      fi
      echo "Waiting for $container to become healthy... ($i/20)"
      sleep 2
    done

    echo "Timeout: $container did not become healthy."
    docker logs "$container" 2>/dev/null | tail -n 20
    exit 1
  }

  wait_for_healthy php_blue
  wait_for_healthy apache_proxy
  wait_for_healthy mysql
  wait_for_healthy phpadmin

  echo "Initial setup complete. Active version: php_blue"  
  exit 0
fi

# Normal deployment flow (switching between blue and green)
ACTIVE_COLOR=$(cat "$ACTIVE_COLOR_FILE")
INACTIVE_COLOR=$( [ "$ACTIVE_COLOR" = "blue" ] && echo "green" || echo "blue" )
echo "Switching to new version on $INACTIVE_COLOR..."

# Build new version
docker-compose build --no-cache php_$INACTIVE_COLOR
echo "Built new version: php_$INACTIVE_COLOR"

# Start new version
docker-compose up -d php_$INACTIVE_COLOR
echo "Waiting for php_$INACTIVE_COLOR to become healthy..."

for i in {1..20}; do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' php_$INACTIVE_COLOR 2>/dev/null)
  if [ "$STATUS" == "healthy" ]; then
    echo "php_$INACTIVE_COLOR is healthy."
    break
  fi
  echo "Waiting... ($i/20)"
  sleep 2
done

if [ "$STATUS" != "healthy" ]; then
  echo "Error: php_$INACTIVE_COLOR did not become healthy. Aborting switch."
  docker-compose stop php_$INACTIVE_COLOR
  docker-compose rm -f php_$INACTIVE_COLOR
  docker images repo_php_$INACTIVE_COLOR -q | xargs -r docker rmi -f || echo "Image not found or already removed."
  exit 1
fi

# Switch proxy
echo "Updating Apache proxy to point to $INACTIVE_COLOR..."
cp ./php_${INACTIVE_COLOR}.conf ./php_active.conf
docker-compose restart proxy

# Stop old version
docker-compose stop php_$ACTIVE_COLOR
docker-compose rm -f php_$ACTIVE_COLOR
echo "Removing old image php_$ACTIVE_COLOR..."
docker images repo_php_$ACTIVE_COLOR -q | xargs -r docker rmi -f || echo "Image not found or already removed."

# Update active color
echo "$INACTIVE_COLOR" > "$ACTIVE_COLOR_FILE"

echo "Deployment switched to $INACTIVE_COLOR successfully."
