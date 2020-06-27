#!/bin/sh
echo "Shutdown kerio-control-vpnclinet..."
DCID=`cat /tmp/container_id.txt | sed -e 's/.* //;q'`

# stop container
docker stop $DCID 1>/dev/null

# clean routing table at host
echo "Removing ip routes..."
for l in $(cat /tmp/current_routes.txt); do
  echo "ip route del $l via 172.17.0.2"
  sudo ip route del $l via 172.17.0.2
done

# remove old container id
rm /tmp/container_id.txt

# restore original resolv.conf
sudo mv /etc/resolv.conf{-backup,}
echo "Finished."
