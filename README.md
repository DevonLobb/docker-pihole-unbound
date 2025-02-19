# docker-pihole-unbound


Pi-hole container using the recursive DNS server unbound.

Enable in Pi-hole by setting custom DNS server to 127.0.0.1#5353

Check if unbound is working: 
```sh
docker exec pihole dig google.com @127.0.0.1 -p 5353
```



### Based on


* [pihole/pihole](https://hub.docker.com/r/pihole/pihole/)
* [Unbound](https://docs.pi-hole.net/guides/unbound/)

### Example Usage
```sh
docker create \
--name pihole \
-p 53:53/tcp \
-p 53:53/udp \
-p 80:80 \
-p 443:443 \
-e TZ=America/New_York \
-e FTLCONF_webserver_port=80 \
-e FTLCONF_webserver_api_password:password \
-e FTLCONF_dns_upstreams=127.0.0.1#5353;9.9.9.9
-v "$(pwd)/pihole/etc-pihole/:/etc/pihole/" \
-v "$(pwd)/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
-v "$(pwd)/pihole/etc-unbound/:/etc/unbound/" \
--cap-add=NET_ADMIN \
--net=host \
--restart=unless-stopped \
--hostname=pi.hole \
ghcr.io/devonlobb/docker-pihole-unbound:master
```

```sh
services:
  pihole:
    container_name: pihole
    image: ghcr.io/devonlobb/docker-pihole-unbound:master
    ports:
      # DNS Ports
      - "53:53/tcp"
      - "53:53/udp"
      # Default HTTP Port
      - "80:80/tcp"
      # Default HTTPs Port. FTL will generate a self-signed certificate
      - "443:443/tcp"
      # Uncomment the below if using Pi-hole as your DHCP Server
      #- "67:67/udp"
    environment:
      # Set the appropriate timezone for your location from
      # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones, e.g:
      TZ: 'Europe/London'
      # Set a password to access the web interface. Not setting one will result in a random password being assigned
      FTLCONF_webserver_api_password: 'correct horse battery staple'
      FTLCONF_webserver_port: 80
      # If using Docker's default `bridge` network setting the dns listening mode should be set to 'all'3
      #FTLCONF_dns_listeningMode: 'all'
      FTLCONF_dns_upstreams: '127.0.0.1#5353;9.9.9.9'
      #ADDITIONAL_PACKAGES: unbound
    # Volumes store your data between container upgrades
    volumes:
      # For persisting Pi-hole's databases and common configuration file      
      - '$(pwd)/pihole/etc-pihole/:/etc/pihole/'
      # For persisting custom dnsmasq config files. Most will not need this, and can be safely removed/commented out
      - '$(pwd)/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/'
      - '$(pwd)/pihole/etc-unbound/:/etc/unbound/'
    cap_add:
      # Required if you are using Pi-hole as your DHCP server, else not needed
      # See Note On Capabilities below
      - NET_ADMIN
    restart: unless-stopped
```
