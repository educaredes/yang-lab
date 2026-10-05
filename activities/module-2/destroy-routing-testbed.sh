#!/bin/bash

echo 'Closing consoles...'
./clab-consoles.sh close

echo 'Done!'

echo ''
echo ''

echo 'Destroying containerlab topology with Nokia SR Linux routers...'

sudo containerlab destroy --topo routing-testbed.yaml
sudo rm -Rf /tmp/.clab
sudo ovs-vsctl del-br s1
sudo ovs-vsctl del-br s2
sudo ovs-vsctl del-br s3

echo 'Done!'

echo ''
echo ''

echo 'All done!'
