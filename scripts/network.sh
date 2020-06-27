#!/bin/sh

# start VPN-client
/etc/init.d/kerio-kvc start

# wait 'till kvnet-interface is up
while ! ip a show kvnet up 2>/dev/null | grep inet 2>/dev/null; do
  sleep 1
done

# configure IP masquerade and activate IP forwarding
iptables -t nat -A POSTROUTING -o kvnet -j MASQUERADE
sysctl -w net.ipv4.ip_forward=1

# print routing table into docker log
ip route

# keep container alive
exec "$@";
