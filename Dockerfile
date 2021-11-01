FROM pihole/pihole:latest


RUN \
	apt-get update && \
	apt-get install unbound wget -y && \
	rm -rf /var/lib/apt/lists/* && \
	wget -O /var/lib/unbound/root.hints https://www.internic.net/domain/named.root && \
	cp /usr/share/dns/root.key /var/lib/unbound/ && \
	touch /var/log/unbound/unbound.log

ADD	unbound_service/* /etc/services.d/unbound/
COPY	unbound_default_config/* /etc/unbound/unbound.conf.d/
