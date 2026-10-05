#!/bin/bash

echo 'Closing consoles...'
./clab-consoles.sh close

echo 'Done!'

echo ''
echo ''

echo 'Destroying containerlab topology with Nokia SR Linux routers...'

sudo containerlab destroy --topo srlinux-testbed.yaml
sudo rm -Rf /tmp/.clab

echo 'Done!'

echo ''
echo ''

echo 'All done!'
