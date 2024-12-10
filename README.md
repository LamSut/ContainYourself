# Play with Containers
Some pratice exercises that help you learn Containers.

## Docker

### Docker installation
To get started, you'll need to have Docker installed on your machine.  
Please follow the official [Docker Installation Guide](https://docs.docker.com/get-docker/).  

### Docker usage
After installation, you can start using Docker to create, deploy, and manage containerized applications.  
For more detailed instructions and advanced topics, refer to the full [Docker Documentation](https://docs.docker.com/).

## Minikube

### Minikube installation
To install Minikube, refer to the official [Minikube Installation Guide](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download).

### Minikube usage

#### Start Minikube
```bash
minikube start
```

#### Set Docker environment

* Unix shells:  
```bash
eval $(minikube docker-env)   
```

* PowerShell:  
```bash          
minikube docker-env | Invoke-Expression
```

For more detailed instructions and advanced topics, refer to the full [Minikube Documentation](https://minikube.sigs.k8s.io/docs/).