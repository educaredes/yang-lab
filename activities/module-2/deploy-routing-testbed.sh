#!/bin/bash

echo 'Deploying containerlab topology with Nokia SR Linux routers...'

sudo ovs-vsctl add-br s1
sudo ovs-vsctl add-br s2
sudo ovs-vsctl add-br s3
sudo mkdir -p /tmp/.clab
sudo curl -L -s https://raw.githubusercontent.com/educaredes/yang-lab/refs/heads/main/activities/module-2/r1.cfg -o /tmp/.clab/r1.cfg
sudo curl -L -s https://raw.githubusercontent.com/educaredes/yang-lab/refs/heads/main/activities/module-2/r2.cfg -o /tmp/.clab/r2.cfg
sudo curl -L -s https://raw.githubusercontent.com/educaredes/yang-lab/refs/heads/main/activities/module-2/r3.cfg -o /tmp/.clab/r3.cfg
sudo containerlab deploy --topo https://raw.githubusercontent.com/educaredes/yang-lab/refs/heads/main/activities/module-2/routing-testbed.yaml

echo 'Done!'

echo ''
echo ''

echo 'Configuring client "pc11" container...'

sudo docker exec -it clab-routing-testbed-pc11 ifconfig eth1 192.168.1.100 netmask 255.255.255.0
sudo docker exec -it clab-routing-testbed-pc11 ip route add 192.168.2.0/24 via 192.168.1.1 dev eth1
sudo docker exec -it clab-routing-testbed-pc11 ip route add 192.168.3.0/24 via 192.168.1.1 dev eth1

echo 'Done!'

echo ''
echo ''

echo 'Configuring client "pc12" container...'

sudo docker exec -it clab-routing-testbed-pc12 ifconfig eth1 192.168.1.101 netmask 255.255.255.0
sudo docker exec -it clab-routing-testbed-pc12 ip route add 192.168.2.0/24 via 192.168.1.1 dev eth1
sudo docker exec -it clab-routing-testbed-pc12 ip route add 192.168.3.0/24 via 192.168.1.1 dev eth1

echo 'Done!'

echo ''
echo ''

echo 'Configuring client "pc21" container...'

sudo docker exec -it clab-routing-testbed-pc21 ifconfig eth1 192.168.2.100 netmask 255.255.255.0
sudo docker exec -it clab-routing-testbed-pc21 ip route add 192.168.1.0/24 via 192.168.2.1 dev eth1
sudo docker exec -it clab-routing-testbed-pc21 ip route add 192.168.3.0/24 via 192.168.2.1 dev eth1

echo 'Done!'

echo ''
echo ''

echo 'Configuring client "pc22" container...'

sudo docker exec -it clab-routing-testbed-pc22 ifconfig eth1 192.168.2.101 netmask 255.255.255.0
sudo docker exec -it clab-routing-testbed-pc22 ip route add 192.168.1.0/24 via 192.168.2.1 dev eth1
sudo docker exec -it clab-routing-testbed-pc22 ip route add 192.168.3.0/24 via 192.168.2.1 dev eth1

echo 'Done!'

echo ''
echo ''

echo 'Configuring client "pc31" container...'

sudo docker exec -it clab-routing-testbed-pc31 ifconfig eth1 192.168.3.100 netmask 255.255.255.0
sudo docker exec -it clab-routing-testbed-pc31 ip route add 192.168.1.0/24 via 192.168.3.1 dev eth1
sudo docker exec -it clab-routing-testbed-pc31 ip route add 192.168.2.0/24 via 192.168.3.1 dev eth1

echo 'Done!'

echo ''
echo ''

echo 'Configuring client "pc32" container...'

sudo docker exec -it clab-routing-testbed-pc32 ifconfig eth1 192.168.3.101 netmask 255.255.255.0
sudo docker exec -it clab-routing-testbed-pc32 ip route add 192.168.1.0/24 via 192.168.3.1 dev eth1
sudo docker exec -it clab-routing-testbed-pc32 ip route add 192.168.2.0/24 via 192.168.3.1 dev eth1

echo 'Done!'

echo ''
echo ''

echo 'Opening consoles...'

./clab-consoles.sh open

echo 'Done!'

echo ''
echo ''

echo 'All done!'
