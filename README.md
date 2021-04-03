#### build image
```
docker build . -t $IMAGE_TAG \
	--build-arg user=$USER \
	--build-arg host_key="$HOST_KEY" \
	--no-cache
```

#### create container
```
docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	--cap-add SYS_ADMIN \
	debian-sid:latest
```

#### access container shell
```
docker exec -it <CONTAINER> /bin/zsh
```

#### push to docker hub
```
docker push $IMAGE_TAG
```

#### push to google container registry
```
docker tag $IMAGE_TAG gcr.io/$PROJECT_NAME/debian-sid
```

```
docker push gcr.io/$PROJECT_NAME/debian-sid
```

#### gcloud
```
gcloud auth login --no-launch-browser
```

```
gcloud config set account $SERVICE_ACCOUNT
```

```
gcloud config set project $PROJECT_NAME
```

#### create cluster
```
gcloud container clusters create $CLUSTER_NAME \
	--zone $ZONE \
	--machine-type $MACHINE_TYPE \
	--num-nodes 1
```

#### get credentials
```
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE --project $PROJECT_NAME
```

#### create namespace, deployment and service
```
kubectl apply -f namespace.yaml
kubectl apply -f deploy-$CLUSTER_NAME.yaml
kubectl apply -f service-$CLUSTER_NAME.yaml
```


#### list addresses for LoadBalancer
```
gcloud compute addresses list $CLUSTER_NAME
```

#### create address for LoadBalancer
```
gcloud compute addresses create $CLUSTER_NAME --region $REGION
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
# gcloud compute ssh --zone $ZONE ngonzalez@gke-app-default-pool-4e6b9dde-mgtk --project $PROJECT_NAME --container=bb554b07995d
```

```
ssh -J <GCLOUD_USER>@<NODE_EXTERNAL_IP> <USER>@<POD_IP>
# ssh -J ngonzalez@35.228.15.33 debian@10.108.0.10
```

```
ssh -o ProxyCommand='ssh -W %h:%p <GCLOUD_USER>@<NODE_EXTERNAL_IP>' <USER>@<POD_IP>
```

#### update gcloud
```
gcloud components update
```
