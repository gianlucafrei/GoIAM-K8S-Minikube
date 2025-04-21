# ELK Stack on Kubernetes (Minikube)

This repository contains Kubernetes manifests for deploying the ELK (Elasticsearch, Logstash, Kibana) Stack on a Minikube cluster, along with Filebeat for log collection. This setup provides a complete logging and analytics solution for your Kubernetes environment.

## Components

- **Elasticsearch**: Distributed search and analytics engine
- **Logstash**: Data processing pipeline
- **Kibana**: Data visualization dashboard
- **Filebeat**: Lightweight log shipper

## Prerequisites

- Minikube installed and running
- kubectl configured to work with your Minikube cluster
- Sufficient resources allocated to Minikube (recommended: 4+ CPU cores, 8+ GB RAM)

## Installation

1. Start Minikube with sufficient resources:
```bash
minikube start --cpus=4 --memory=8192
```

2. Enable the ingress addon:
```bash
minikube addons enable ingress
```

3. Deploy the ELK Stack components:

```bash
# Deploy Elasticsearch
kubectl apply -f elk-stack/es-deployment.yaml
kubectl apply -f elk-stack/es-svc.yaml

# Deploy Kibana
kubectl apply -f elk-stack/kibana-deployment.yaml
kubectl apply -f elk-stack/kibana-svc.yaml

# Deploy Logstash
kubectl apply -f elk-stack/logstash-deployment.yml
kubectl apply -f elk-stack/logstash-svc.yml
kubectl apply -f elk-stack/logstash-configmap.yaml

# Deploy Filebeat
kubectl apply -f elk-stack/filebeat-serviceaccount.yaml
kubectl apply -f elk-stack/filebeat-role.yaml
kubectl apply -f elk-stack/filebeat-rolebinding.yaml
kubectl apply -f elk-stack/filebeat-configmap.yaml
kubectl apply -f elk-stack/filebeat-daemonset.yaml
```

## Accessing the Stack

1. Get the Kibana service URL:
```bash
minikube service kibana --url
```

2. Open the URL in your browser to access the Kibana dashboard (default port: 5601)

## Configuration

- Elasticsearch is configured to run as a single-node cluster
- Logstash is configured to receive logs from Filebeat and forward them to Elasticsearch
- Filebeat is deployed as a DaemonSet to collect logs from all nodes
- Kibana is configured to connect to the Elasticsearch service

## Updating Logstash Configuration

To update the Logstash configuration:

1. Modify the `elk-stack/logstash.conf` file
2. Run the update script:
```bash
./elk-stack/update_logstash.sh
```

## Troubleshooting

- Check pod status:
```bash
kubectl get pods -n default
```

- View pod logs:
```bash
kubectl logs <pod-name>
```

- Check service status:
```bash
kubectl get svc
```

## Cleanup

To remove all deployed resources:
```bash
kubectl delete -f elk-stack/
```
