# docker-pihole-unbound


Pi-hole container using the recursive DNS server unbound.

Enable in Pi-hole by setting custom DNS server to 127.0.0.1#5353

Check if unbound is running: 
```sh
docker exec pihole s6-svstat /var/run/s6/services/unbound
```



### Based on


* [pihole/pihole](https://hub.docker.com/r/pihole/pihole/)
* [Unbound](https://docs.pi-hole.net/guides/unbound/)

### Example Usage
```sh
docker create \
--name pihole \
-p 53:53/tcp -p 53:53/udp \
-p 80:80 \
-p 443:443 \
-e TZ=America/New_York \
-e WEBPASSWORD:password \
-e ServerIP=172.16.1.101 \
-e IPv6=false \
-e DNS1=127.0.0.1#5353 \
-e DNS2=9.9.9.9 \
-v "$(pwd)/etc-pihole/:/etc/pihole/" \
-v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
-v "$(pwd)/etc-unbound/:/etc/unbound/" \
-dns=127.0.0.1 --dns=9.9.9.9 \
--cap-add=NET_ADMIN \
--net=host \
--restart=unless-stopped \
--hostname=pi.hole \
ghcr.io/devonkupiec/docker-pihole-unbound:master

```
