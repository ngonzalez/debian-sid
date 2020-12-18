#### build image
```
docker build . -t ngonzalez121/debian-sid \
	--build-arg user=debian \
	--build-arg host_key="$(cat ~/.ssh/id_rsa.pub)" \
	--no-cache
```

#### push to docker hub
```
docker push ngonzalez121/debian-sid
```

#### push to google container registry
```
docker tag ngonzalez121/debian-sid gcr.io/${PROJECT_NAME}/debian-sid
```

```
docker push gcr.io/${PROJECT_NAME}/debian-sid
```

```
gcloud container images list-tags gcr.io/${PROJECT_NAME}/debian-sid
```
