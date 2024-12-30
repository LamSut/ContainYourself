#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# define variables
REPO_URL="https://github.com/LamSut/PizzaGout"
REPO_DIR="repo"
CONFIG_FILES=("./config/docker-compose.yaml" "./config/redis-deployment.yaml" "./config/mysql-deployment.yaml" "./config/backend-deployment.yaml" "./config/frontend-deployment.yaml")

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

# change to repository directory
echo "Changing to repository directory..."
cd $REPO_DIR || { echo "Failed to enter $REPO_DIR"; exit 1; }

# build Docker images
echo "Building Docker images..."
docker-compose build || { echo "Failed to build with Docker Compose"; exit 1; }

# deploy with Minikube
echo "Applying Kubernetes deployment..."
# minikube kubectl -- apply -f redis-deployment.yaml || { echo "Failed to apply Redis deployment"; exit 1; }
minikube kubectl -- apply -f mysql-deployment.yaml || { echo "Failed to apply MySQL deployment"; exit 1; }
minikube kubectl -- apply -f backend-deployment.yaml || { echo "Failed to apply Backend deployment"; exit 1; }
minikube kubectl -- apply -f frontend-deployment.yaml || { echo "Failed to apply Frontend deployment"; exit 1; }


# ensure pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# forward ports
echo "Forwarding MySQL port..."
minikube kubectl -- port-forward svc/mysql 3306:3306 &

# # echo "Forwarding Redis port..."
# minikube kubectl -- port-forward svc/redis 6379:6379 &

echo "Forwarding BE port..."
minikube kubectl -- port-forward svc/backend 3000:3000 &

echo "Forwarding FE port..."
minikube kubectl -- port-forward svc/frontend 5173:5173 &

# finish
echo "Setup complete! Services can be accessed via the following URLs:"
echo "- MySQL: http://localhost:3306"
echo "- Redis: http://localhost:6379"
echo "- Backend: http://localhost:3000"
echo "- Frontend: http://localhost:5173"
