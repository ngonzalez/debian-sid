#### source environment file
```
source gcp.sh
```

#### push image to google container registry
```
docker tag ngonzalez121/debian-sid gcr.io/${PROJECT_NAME}/debian-sid
```

```
docker push gcr.io/${PROJECT_NAME}/debian-sid
```

```
gcloud container images list-tags gcr.io/${PROJECT_NAME}/debian-sid
```

#### create cluster
```
gcloud container clusters create $CLUSTER_NAME --zone $ZONE
```

#### get credentials
```
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE --project $PROJECT_NAME
```

#### deployment to gcp
```
kubectl apply -f namespace.yaml
kubectl apply -f deploy.yaml
kubectl apply -f service.yaml
```

#### get informations
```
kubectl -n hebe get deployments -o wide
kubectl -n hebe get nodes -o wide
kubectl -n hebe get pods -o wide
kubectl -n hebe get services -o wide
```

#### detailed informations
```
kubectl -n hebe describe deployments
kubectl -n hebe describe nodes
kubectl -n hebe describe pods
kubectl -n hebe describe services
```

#### ssh into pod
```
gcloud compute ssh --zone $ZONE <NODE> --project $PROJECT_NAME --container=<POD>
```

```
ssh -J <GCLOUD_USER>@<NODE_EXTERNAL_IP> <USER>@<POD_IP>
```

```
ssh -o ProxyCommand='ssh -W %h:%p <GCLOUD_USER>@<NODE_EXTERNAL_IP>' <USER>@<POD_IP>
```
