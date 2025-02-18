FROM pihole/pihole:latest

RUN \
	apk update && \
	apk add unbound wget -f && \
	wget -O /var/lib/unbound/root.hints https://www.internic.net/domain/named.root && \
	cp /usr/share/dns/root.key /var/lib/unbound/ && \
	mkdir /var/log/unbound && touch /var/log/unbound/unbound.log && chown -R unbound:unbound /var/log/unbound

ADD	debian-root/ /
COPY	unbound_default_config/* /etc/unbound/unbound.conf.d/
