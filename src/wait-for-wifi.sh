WIFI_TEST_IP=${WIFI_TEST_IP:-192.168.1.1}

wait_for_wifi() {
  max_retry=30
  counter=0

  ping -c 1 $WIFI_TEST_IP >/dev/null 2>&1
  while [ $? -ne 0 ]; do
    [ $counter -eq $max_retry ] && echo "Couldn't connect to Wi-Fi" && exit 1
    counter=$((counter+1))

    sleep 1
    ping -c 1 $WIFI_TEST_IP >/dev/null 2>&1
  done
}

wait_for_wifi
echo 'Wi-Fi connected'
