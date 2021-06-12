#!/bin/sh

set -ue

usage() {
	echo "$0 [-h] [-p port_number]"
}

# todo add command line option for set port
PORT_NUMBER_DEFAULT=8080
PORT_NUMBER=${PORT_NUMBER:-${PORT_NUMBER_DEFAULT}}

if command -v podman > /dev/null 2>&1; then
	CONTAINER_ENGINE=podman
elif command -v docker > /dev/null 2>&1; then
	CONTAINER_ENGINE=docker
else
	echo "No container engine found!!!"
	exit 1
fi

"${CONTAINER_ENGINE}" run --rm -d \
	--name www-nginx \
	-p "${PORT_NUMBER}:80" \
	-v "${PWD}"/www:/usr/share/nginx/html:ro \
	nginx
