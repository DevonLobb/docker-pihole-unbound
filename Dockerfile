FROM			pihole/pihole:latest

LABEL			pihole_version="v6"

RUN \
			apk update && \
			apk add unbound -f && \
			wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints && \
			mkdir /var/log/unbound && touch /var/log/unbound/unbound.log && chown -R unbound:unbound /var/log/unbound

COPY			unbound_default_config/pi-hole.conf /etc/unbound/unbound.conf 
COPY --chmod=0755	start_unbound.sh /usr/bin/start_unbound.sh
ENTRYPOINT		["start_unbound.sh"]
