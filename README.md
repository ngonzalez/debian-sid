# debian-sid

![docker_facebook_share](https://user-images.githubusercontent.com/26479/113612129-b51b9a80-964f-11eb-8054-56f6079c3dcc.png)

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
	$IMAGE_TAG:latest
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
docker tag $IMAGE_TAG gcr.io/$PROJECT_NAME/$IMAGE_TAG
```

```
docker push gcr.io/$PROJECT_NAME/$IMAGE_TAG
```
