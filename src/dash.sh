DIR="$(dirname $0)"
DASH_PNG="$DIR/dash.png"
REFRESH_SCHEDULE=${REFRESH_SCHEDULE:-"0 2,32 8-17 * * 2-6"}
RTC=/sys/devices/platform/mxc_rtc.0/wakeup_enable

init() {
  echo "Starting dashboard with $REFRESH_SCHEDULE refresh..."

  /etc/init.d/framework stop
  initctl stop webreader > /dev/null 2>&1
  echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
  lipc-set-prop com.lab126.powerd preventScreenSaver 1
}

prepare_sleep() {
  echo "Preparing sleep"

  /usr/sbin/eips -f -g "$DIR/sleeping.png"
  
  # Give screen time to refresh
  sleep 2
}

refresh_dashboard() {
  echo "Refreshing dashboard"
  "$DIR/wait-for-wifi.sh"

  "$DIR/local/fetch-dashboard.sh" "$DASH_PNG"
  /usr/sbin/eips -g "$DASH_PNG"
}

log_battery_stats() {
  power_state=$(lipc-get-prop -s com.lab126.powerd state)
  battery_level=$(gasgauge-info -c)

  echo "$(date) Battery level: $batter_level. Power state: $power_state"
}

rtc_sleep() {
  duration=$1

  [ $(cat "$RTC") -eq 0 ] && echo -n "$duration" > "$RTC"
  echo "mem" > /sys/power/state
}

main_loop() {
  while true ; do
    log_battery_stats

    next_wakeup_secs=$("$DIR/next-wakeup" "$REFRESH_SCHEDULE")

    if [ $next_wakeup_secs -gt 3600 ]; then
      action="sleep"
      prepare_sleep
    else
      action="suspend"
      refresh_dashboard
    fi

    # take a bit of time before going to sleep, so this process can be aborted
    sleep 10

    echo "Going to $action, next wakeup in ${next_wakeup_secs}s"

    rtc_sleep $next_wakeup_secs
  done
}

init
main_loop
