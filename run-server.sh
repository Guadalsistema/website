#!/bin/sh

set -ue

if command -v podman > /dev/null 2>&1; then
	CONTAINER_ENGINE=podman
elif command -v docker > /dev/null 2>&1; then
	CONTAINER_ENGINE=docker
else
	echo "No container engine found!!!"
	exit 1
fi

"${CONTAINER_ENGINE}" run --rm -d \
    --name guadalsistema-nginx \
    -p "8080:80" \
	-v "$PWD/www":/usr/share/nginx/html:ro \
    nginx
