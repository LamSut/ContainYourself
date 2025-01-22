# Prometheus & Grafana

## Install Helm CLI
Helm is the package manager for Kubernetes, which can be used for deploying Prometheus and Grafana.  
To install Helm, refer to the official [Helm Installation Guide](https://helm.sh/docs/intro/install).

## Deploy Prometheus & Grafana
```bash
chmod 755 monitoring.sh && ./monitoring.sh
```
Prometheus service is now accessible via: http://localhost:9090/  
Grafana service is now accessible via: http://localhost:3030/  

## Config Grafana to use Prometheus
