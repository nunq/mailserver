#!/bin/bash
logfile="./monitor.log"
DOMAIN=""
MAILDOMAIN="mail.""$DOMAIN"
APICALL=""
# check working inet for this machine
ping -q -w 2 -c 1 1.1.1.1 || echo "no internet connection" >> "$logfile"
ping -q -w 2 -c 2 "$DOMAIN" || echo "dns doesn't work" >> "$logfile"
# notify func
notify() {
  curl -X GET "$APICALL""$1"
  exit 1
}
# actual monitoring
ping -c 2 "$DOMAIN" || notify "couldn't%20ping%20domain%20name"
# port 25
nc -w 2 "$MAILDOMAIN" 25 || notify "port%2025%20on%20"$MAILDOMAIN"%20is%20dead"
nc -w 2 "$DOMAIN" 25 || notify "port%2025%20on%20"$DOMAIN"%20is%20dead"
# port 465
nc -w 2 "$MAILDOMAIN" 465 || notify "port%20465%20on%20"$MAILDOMAIN"%20is%20dead"
nc -w 2 "$DOMAIN" 465 || notify "port%20465%20on%20"$DOMAIN"%20is%20dead"
# port 993
nc -w 2 "$MAILDOMAIN" 993 || notify "port%20993%20on%20"$MAILDOMAIN"%20is%20dead"
nc -w 2 "$DOMAIN" 993 || notify "port%20993%20on%20"$DOMAIN"%20is%20dead"
