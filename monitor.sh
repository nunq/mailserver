#!/bin/bash
set -x
logfile="./monitor.log"
DOMAIN=""
IP=""
MAILDOMAIN="mail.""$DOMAIN"
APICALL=""
# check working inet for this machine
ping -q -4 -w 2 -c 1 1.1.1.1 || err "no internet connection"
ping -q -4 -w 2 -c 2 google.com || err "dns doesn't work"

err() {
  echo ""$(date)""$1"" >> "$logfile"
  exit 1
}
# notify func
notify() {
  curl "$APICALL""$1"
  exit 0
}
# actual monitoring
ping -q -4 -w 3 -c 2 "$IP" || notify "server%20is%20down%20%28couldn%27t%20ping%20IP%29"
ping -q -4 -w 3 -c 2 "$DOMAIN" || notify "couldn%27t%20ping%20domain%20name"
# port 25
nc -w 5 "$MAILDOMAIN" 25 || notify "port%2025%20on%20"$MAILDOMAIN"%20is%20dead"
# port 465
timeout 5s openssl s_client -connect "$MAILDOMAIN"":465" || notify "port%20465%20on%20"$MAILDOMAIN"%20is%20dead"
# port 993
timeout 5s openssl s_client -connect "$MAILDOMAIN"":993" || notify "port%20993%20on%20"$MAILDOMAIN"%20is%20dead"
