#!/bin/bash

echo "Scan start"

# 100,200,300,400,600
RESOLUTION=${RESOLUTION:-600}
MODE=${MODE:-"24bit Color"}
QUALITY=${QUALITY:-90}
OUT_DIR=/scanner
OUTPUT_FILE="${OUT_DIR}/scan_$(date +%Y-%m-%d-%H-%M-%S)"
DEVICE=${1}
NAME=${2}

beep -f 2000 -l 300 -D 50 -n -f 2000 -l 300 -D 50 -n -f 3000 -l 300 &

#mkdir -p $OUT_DIR

if [[ ! -d "${OUT_DIR}" ]]
then
	echo "Output directory ${OUT_DIR} does not exist" 1>&2
	exit 1
fi

#sleep 0.1

echo "Scan started for ${NAME} -- ${DEVICE}"
echo "  Mode       ${MODE}"
echo "  Resolution ${RESOLUTION}"
echo "  Quality    ${QUALITY}"
echo "  Output     ${OUTPUT_FILE}.jpg"

scanimage --format=tiff --mode "${MODE}" --device-name "${DEVICE}" --resolution ${RESOLUTION} 1> "${OUTPUT_FILE}.tiff"

# Sometimes scanimage fails on first attempt
#if [[ ! -s $OUTPUT_FILE ]]
#then
#	sleep  1
#	scanimage --format=tiff --mode "${MODE}" --device-name "${DEVICE}" --resolution ${RESOLUTION} 1> "${OUTPUT_FILE}.tiff"
#fi

echo "Converting..."
convert -quality ${QUALITY} "${OUTPUT_FILE}.tiff" "${OUTPUT_FILE}.jpg"
rm "${OUTPUT_FILE}.tiff"
chown scanner "${OUTPUT_FILE}.jpg"

beep -f 3000 -l 300 -D 50 -n -f 3000 -l 300 -D 50 -n -f 2000 -l 300 &

echo "Scan complete"
