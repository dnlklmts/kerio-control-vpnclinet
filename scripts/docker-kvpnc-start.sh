#!/bin/sh
echo "Starting kerio-control-vpnclinet..."
rm /tmp/current_routes.txt

# save current resolv.conf
sudo cp /etc/resolv.conf{,-backup}

# run container, share resolv.conf,
#   and save container id
docker run -d -t -i --rm --privileged -v /etc/resolv.conf:/etc/resolv.conf $1 /bin/bash | awk '{ print $1 }' > /tmp/container_id.txt
DCID=`cat /tmp/container_id.txt | sed -e 's/.* //;q'`

# wait 'till kvnet-interface is up
#   and save routing table from docker log
echo "Waiting for logfile..."
while ! grep "10.0.0.0/8" /tmp/current_routes.txt 1>/dev/null; do
  sleep 5
  docker logs $DCID | awk '{ print $1 }' | sed -n '/^[0-9]/p' | sed -n '1,$p' | sed '/172.17.0.0\/16/d' > /tmp/current_routes.txt
done

# sync routing tables
#   where 172.17.0.2 is container IP-address
echo "Adding ip routes..."
for l in $(cat /tmp/current_routes.txt); do
  echo "ip route add $l via 172.17.0.2"
  sudo ip route add $l via 172.17.0.2
done

echo "Finished."
