FROM debian:stable

ARG deb

ADD ./scripts/install.sh /tmp/install.sh
COPY ./scripts/network.sh /usr/bin/network.sh
 
# Copy latest URL from http://download.kerio.com/archive/
ADD http://cdn.kerio.com/dwn/control/control-9.3.4-3795/kerio-control-vpnclient-9.3.4-3795-linux-amd64.deb /tmp/kerio.deb

RUN apt-get update && apt-get install -y debconf iproute2 openssl libuuid1 procps iptables

RUN sh /tmp/install.sh

ENTRYPOINT ["/usr/bin/network.sh"]
