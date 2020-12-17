#### build image
```
docker build ~/Sites/debian-sid \
	-t ngonzalez121/debian-sid \
	--build-arg ssh_pub_host="$(cat ~/.ssh/id_rsa.pub)" \
	--no-cache
```

#### push image to google container registry
```
docker tag ngonzalez121/debian-sid gcr.io/hebe-001/debian-sid
```

```
docker push gcr.io/hebe-001/debian-sid
```
