#!/bin/bash
USAGE="
Usage:
./gnmic-get-routing-config.sh <container_name>
    being:
        <container_name>: the name of the Docker container running the SR Linux device.
"
if [[ $# -ne 1 ]]; then
    echo ""
    echo "ERROR: incorrect number of parameters."
    echo "$USAGE"
    exit 1
fi

gnmic -a $1:57400 -u admin -p NokiaSrl1! get --path "/network-instance[name=default]" --type config --skip-verify --encoding JSON_IETF
