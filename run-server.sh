#!/bin/sh

set -ue

PORT_NUMBER_DEFAULT=8080
CONTAINER_NAME_DEFAULT=www-nginx

usage() {
	printf "%s [-h] [-p port_number] [-n container_name]\n" "$(basename "$0")"
	cat << EOF
Flags usage:
	-h display help and exit
	-p set the port for the server. default: ${PORT_NUMBER_DEFAULT}
	-n set the name for the container. default: ${CONTAINER_NAME_DEFAULT}
EOF
}

is_number='^[0-9]+$'
while getopts "hvp:n:" flag
do
	case "$flag" in
		h) usage; exit 0;;
		p)
			if echo "${OPTARG}" | grep -Eq "${is_number}"; then
				PORT_NUMBER=${OPTARG}
			else
				echo "Error: ${OPTARG}"" is not a valid port number"
				exit 1
			fi
			;;
		n) CONTAINER_NAME="${OPTARG}";;
		*) usage; exit 1;;
	esac
done

# todo add command line option for set port
PORT_NUMBER=${PORT_NUMBER:-${PORT_NUMBER_DEFAULT}}
CONTAINER_NAME=${CONTAINER_NAME:-${CONTAINER_NAME_DEFAULT}}

if command -v podman > /dev/null 2>&1; then
	CONTAINER_ENGINE=podman
elif command -v docker > /dev/null 2>&1; then
	CONTAINER_ENGINE=docker
else
	echo "No container engine found!!!"
	exit 1
fi

"${CONTAINER_ENGINE}" run --rm -d \
	--name "${CONTAINER_NAME}" \
	-p "${PORT_NUMBER}:80" \
	-v "${PWD}"/www:/usr/share/nginx/html:ro \
	nginx
