#!/bin/bash

echo "Starting..."

if ! grep -sqi "${CUPSADMIN}" /etc/shadow
then
	echo "Adding admin user..."
	useradd -r -G lpadmin -M "${CUPSADMIN}"
	echo "${CUPSADMIN}:${CUPSPASSWORD}" | chpasswd
fi

echo "Ready"

exec /usr/sbin/cupsd -f
