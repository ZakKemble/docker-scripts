#!/bin/bash

OUTPUT_DIR=/mnt/storage1/scanner
BRSCAN_USER=saned

# BRSCAN_USER is used to set the owner of scanned images


cd $(dirname "${BASH_SOURCE[0]}")

beep -f 2000 -l 100 -D 50 -r 2

if ! grep -sqi ${BRSCAN_USER} /etc/shadow
then
	echo "Adding BRSCAN user..."
	useradd -r -M ${BRSCAN_USER} -s /sbin/nologin
fi

if ! docker image inspect scanner > /dev/null
then
	docker build --progress=plain -t scanner .
fi

docker run \
	--privileged \
	--rm \
	-d \
	--name scanner \
	-v /dev/bus/usb:/dev/bus/usb \
	-v "${OUTPUT_DIR}":/scanner \
	-e BRSCAN_USER=$(id -u ${BRSCAN_USER}) \
	-e RESOLUTION=600 \
	-e MODE="24bit Color" \
	-e QUALITY=90 \
	scanner
