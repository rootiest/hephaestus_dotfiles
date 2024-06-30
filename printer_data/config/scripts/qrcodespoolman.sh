#!/bin/sh
# NonaSuomy PoC scan QRCodes via 3D printer camera
wget http://localhost/webcam/?action=snapshot -O /home/pi/printer_data/gcodes/qrcode.jpg
SPOOLID=$(zbarimg -S*.enable /home/pi/printer_data/gcodes/qrcode.jpg | sed 's/[^0-9]*\([0-9]\+\).*/\1/')
echo $SPOOLID
curl -X POST -H "Content-Type: application/json" -d "{\"spool_id\": \"$SPOOLID\"}" http://localhost:7125/server/spoolman/spool_id