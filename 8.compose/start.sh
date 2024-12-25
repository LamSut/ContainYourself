#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# define variables
REPO_URL="https://github.com/LamSut/PizzaGout"
REPO_DIR="repo"
CONFIG_FILES=("./config/docker-compose.yaml" "./config/deployment.yaml")
VITE_CONFIG="./config/vite.config.js"

# clone repository
if [ -d "$REPO_DIR" ]; then
  echo "Repository directory $REPO_DIR already exists. Skipping clone."
else
  echo "Cloning the repository..."
  git clone $REPO_URL $REPO_DIR || { echo "Failed to clone repository"; exit 1; }
fi

# copy config files
echo "Copying configuration files..."
for file in "${CONFIG_FILES[@]}"; do
  cp $file $REPO_DIR || { echo "Failed to copy $file"; exit 1; }
done
cp $VITE_CONFIG $REPO_DIR/frontend || { echo "Failed to copy $VITE_CONFIG"; exit 1; }

# change to repository directory
echo "Changing to repository directory..."
cd $REPO_DIR || { echo "Failed to enter $REPO_DIR"; exit 1; }

# build Docker images
echo "Building Docker images..."
docker-compose build || { echo "Failed to build with Docker Compose"; exit 1; }

# deploy with Minikube
echo "Applying Kubernetes deployment..."
minikube kubectl -- apply -f deployment.yaml || { echo "Failed to apply Kubernetes deployment"; exit 1; }

# ensure pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# forward ports
echo "Forwarding MySQL port..."
minikube kubectl -- port-forward svc/mysql 3306:3306 &

echo "Forwarding BE port..."
minikube kubectl -- port-forward svc/backend 3000:3000 &

echo "Forwarding FE port..."
minikube kubectl -- port-forward svc/frontend 5173:5173 &

# finish
echo "Setup complete! Services can be accessed via the following URLs:"
echo "- MySQL: http://localhost:3306"
echo "- Backend: http://localhost:3000"
echo "- Frontend: http://localhost:5173"
