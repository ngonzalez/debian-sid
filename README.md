#### config
```
export IMAGE_TAG='ngonzalez121/debian-sid'
export USER='debian'
export HOST_KEY=$(cat ~/.ssh/id_rsa.pub)
export PROJECT_NAME='hebe-001'
```

#### build image
```
docker build . -t $IMAGE_TAG \
	--build-arg user=$USER \
	--build-arg host_key="$HOST_KEY" \
	--no-cache
```

#### push to docker hub
```
docker push $IMAGE_TAG
```

#### push to google container registry
```
docker tag $IMAGE_TAG gcr.io/${PROJECT_NAME}/debian-sid
```

```
docker push gcr.io/${PROJECT_NAME}/debian-sid
```

```
gcloud container images list-tags gcr.io/${PROJECT_NAME}/debian-sid
```

#### load gcp config
```
export CLUSTER_NAME='app-cluster'
export NAMESPACE='hebe'
export REGION='europe-north1'
export ZONE='europe-north1-a'
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
kubectl -n $NAMESPACE get deployments -o wide
kubectl -n $NAMESPACE get nodes -o wide
kubectl -n $NAMESPACE get pods -o wide
kubectl -n $NAMESPACE get services -o wide
```

#### detailed informations
```
kubectl -n $NAMESPACE describe deployments
kubectl -n $NAMESPACE describe nodes
kubectl -n $NAMESPACE describe pods
kubectl -n $NAMESPACE describe services
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
