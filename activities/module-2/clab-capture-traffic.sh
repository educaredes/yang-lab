#!/bin/bash

docker_name=$1
docker_iface=$2

# List of container names and interfaces
container_names=('clab-routing-testbed-pc11' 'clab-routing-testbed-pc12' 'clab-routing-testbed-pc21' 'clab-routing-testbed-pc22' 'clab-routing-testbed-pc31' 'clab-routing-testbed-pc32' 'clab-routing-testbed-r1' 'clab-routing-testbed-r2' 'clab-routing-testbed-r3')
container_ifaces_routers=('e1-1' 'e1-2' 'e1-3' 'mgmt0')
container_ifaces_hosts=('eth0' 'eth1')
allcontainers=${container_names[*]}
allifaces_routers=${container_ifaces_routers[*]}
allifaces_hosts=${container_ifaces_hosts[*]}

USAGE="
Usage:
  ./clab-capture-traffic.sh <container_name> <interface>
    to open capture on specific container interface
    Valid values:
      <container_name>: $allcontainers
      <container_interface>: $allifaces_routers for router containers, $allifaces_hosts for host containers
"

if [ "$#" -ne 2 ] ; then
    echo "$USAGE"
    exit 1
    
else 
    if [[ ! " ${container_names[@]} " =~ " $1 " ]]; then
        echo ""
        echo "ERROR: unknown container '$1'"
        echo "$USAGE"
        exit 1
    else
        for containername in "${container_names[@]}"; do

	    if [[ "$containername" == clab-srlinux-testbed-r* && "$containername" == "$1" ]]; then

	        if [[ ! " ${container_ifaces_routers[*]} " =~ " $2 " ]]; then
		    echo "ERROR: interface '$2' is not valid for router '$containername'"
		    exit 1
		fi

	    elif [[ "$containername" == clab-srlinux-testbed-pc* && "$containername" == "$1" ]]; then

		if [[ ! " ${container_ifaces_hosts[*]} " =~ " $2 " ]]; then
		    echo "ERROR: interface '$2' is not valid for host '$containername'"
		    exit 1
		fi

	    fi

        done
    fi
fi

if docker ps -a --format '{{.Names}}' | grep -q "^${docker_name}$"; then
    echo "Capturing traffic from '{$docker_iface}' interface in '${docker_name}' docker container..."
    sudo ip netns exec $docker_name tcpdump -U -nni $docker_iface -w - | wireshark -k -i - &
else
    echo "WARNING: container '${docker_name}' not started"
fi