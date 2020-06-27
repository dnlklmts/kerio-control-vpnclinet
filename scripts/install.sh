(
#server
sleep 1
echo "hostname"

#autodetect
sleep 1
echo "yes"

#fingerprint ..
sleep 1
echo "yes"

#username
sleep 1
echo "username"

#password
sleep 1
echo "password"

sleep 1) | dpkg -i /tmp/kerio.deb
