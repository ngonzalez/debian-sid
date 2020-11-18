```
docker network create \
  --driver=bridge \
  --subnet=172.28.0.0/16 \
  --ip-range=172.28.5.0/24 \
  --gateway=172.28.5.254 \
  br0
```

```
docker build github.com/ngonzalez/debian-sid --no-cache -t debian-sid \
    --build-arg ssh_pub_host="$(cat ~/.ssh/id_rsa.pub)" \
    --build-arg ssh_prv_key="$(cat ~/.ssh/debian-sid/id_rsa)" \
    --build-arg ssh_pub_key="$(cat ~/.ssh/debian-sid/id_rsa.pub)"
```

```
docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --cap-add SYS_ADMIN \
    --dns 192.168.1.1 \
    --hostname sid.home \
    --ip 172.28.5.1 \
    --name docker-debian-sid \
    --network br0 \
    -p 2200:22 \
    debian-sid:latest
```

```
docker exec -it <container_name> /bin/zsh
```

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name>
```
