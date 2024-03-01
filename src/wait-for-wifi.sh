#!/usr/bin/env sh
test_ip=$1

source ./logging.sh

if [ -z "$test_ip" ]; then
  log -l ERROR "No test ip specified"
  exit 1
fi

wait_for_wifi() {
  max_retry=30
  counter=0

  ping -c 1 "$test_ip" >/dev/null 2>&1

  # shellcheck disable=SC2181
  while [ $? -ne 0 ]; do
    [ $counter -eq $max_retry ] && log -l ERROR "Couldn't connect to Wi-Fi" && exit 1
    counter=$((counter + 1))

    sleep 1
    ping -c 1 "$test_ip" >/dev/null 2>&1
  done
}

wait_for_wifi
log "Wi-Fi connected"