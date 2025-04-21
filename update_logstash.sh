kubectl create configmap log-manual-pipeline --from-file=logstash.conf --dry-run=client -o yaml > logstash-configmap.yaml
kubectl apply -f logstash-configmap.yaml
kubectl rollout restart deployment logstash-logging