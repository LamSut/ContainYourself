#!/bin/bash

# stop and remove Prometheus and Grafana resources
echo "Stopping Prometheus and Grafana..."

# change Docker daemon to Minikube
eval $(minikube docker-env)

# namespace
NAMESPACE="monitoring"

# terminate port-forwarding processes
PROMETHEUS_PORT_FORWARD_PID=$(pgrep -f "port-forward -n $NAMESPACE svc/prometheus-server")
GRAFANA_PORT_FORWARD_PID=$(pgrep -f "port-forward -n $NAMESPACE svc/grafana")

if [ -n "$PROMETHEUS_PORT_FORWARD_PID" ]; then
  echo "Terminating Prometheus port-forwarding (PID: $PROMETHEUS_PORT_FORWARD_PID)..."
  kill $PROMETHEUS_PORT_FORWARD_PID
fi

if [ -n "$GRAFANA_PORT_FORWARD_PID" ]; then
  echo "Terminating Grafana port-forwarding (PID: $GRAFANA_PORT_FORWARD_PID)..."
  kill $GRAFANA_PORT_FORWARD_PID
fi

# uninstall Prometheus
echo "Uninstalling Prometheus..."
helm uninstall prometheus --namespace $NAMESPACE
if [ $? -eq 0 ]; then
  echo "Prometheus uninstalled successfully."
else
  echo "Failed to uninstall Prometheus."
fi

# uninstall Grafana
echo "Uninstalling Grafana..."
helm uninstall grafana --namespace $NAMESPACE
if [ $? -eq 0 ]; then
  echo "Grafana uninstalled successfully."
else
  echo "Failed to uninstall Grafana."
fi

# delete the monitoring namespace
echo "Deleting namespace: $NAMESPACE..."
minikube kubectl -- delete namespace $NAMESPACE
if [ $? -eq 0 ]; then
  echo "Namespace $NAMESPACE deleted successfully."
else
  echo "Failed to delete namespace $NAMESPACE or it does not exist."
fi

# finish
echo "Prometheus and Grafana resources have been removed."
exit 0