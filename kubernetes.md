# cluster
. ./gcp.sh; gcloud container images list-tags $IMAGE
. ./gcp.sh; gcloud container clusters create $CLUSTER_NAME --zone $ZONE
. ./gcp.sh; gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE --project $PROJECT_NAME
. ./gcp.sh; gcloud compute ssh --zone $ZONE gke-app-001-cluster-default-pool-43ecba56-m0p7 --project $PROJECT_NAME --container=a988377f00a1

# deployment
kubectl apply -f namespace.yaml
kubectl apply -f deploy.yaml
kubectl apply -f service.yaml

kubectl -n hebe get deployments -o wide
kubectl -n hebe get nodes -o wide
kubectl -n hebe get pods -o wide
kubectl -n hebe get services -o wide

kubectl -n hebe describe deployments
kubectl -n hebe describe nodes
kubectl -n hebe describe pods
kubectl -n hebe describe services

# ssh -J ngonzalez@35.228.154.9 debian@10.24.1.4
# ssh -o ProxyCommand='ssh -W %h:%p ngonzalez@35.228.154.9' debian@10.24.1.4

# kubectl -n hebe get no -o json | jq -r '[.items[] | {name:.metadata.name, external_ip:.status.addresses[] | select(.type=="ExternalIP"), internal_ip:.status.addresses[] | select(.type=="InternalIP") }]'

# kubectl -n hebe get po -o json | jq -r '[.items[] | {name:.metadata.name, host_ip:.status.hostIP, pod_ip:.status.podIP }]'
