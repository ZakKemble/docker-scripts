#!/bin/bash

echo "Starting..."

onSignal()
{
	echo "Terminating"
	brscan-skey -t
	beep -f 2000 -l 100 -D 50 -n -f 2000 -l 100 -d 50 -n -f 2000 -l 200
	exit 0
}

trap onSignal INT TERM

beep -f 3000 -l 100 -D 50 -n -f 3000 -l 100 -d 50 -n -f 5000 -l 200

useradd -M -u ${BRSCAN_USER:-2000} -g 0 -r -s /usr/sbin/nologin scanner
#runuser -u scanner brscan-skey
brscan-skey

echo "Ready"

# Play a beep tune every 30 minutes to remind me that the printer is still powered on
while true
do
	# This sleep/wait stuff is needed so that the signal trap is triggered when the cotainer is requested to shutdown
	sleep 1800 &
	wait $!
	beep -f 5000 -l 300 -D 50 -n -f 3000 -l 100 -n -f 5000 -l 300 -D 50 -n -f 3000 -l 100 -n -f 5000 -l 300 -D 50
done
