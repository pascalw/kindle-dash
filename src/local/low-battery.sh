#!/usr/bin/env sh
battery_level_percentage=$1
last_battery_report_state="$(dirname "$0")/state/last_battery_report"

previous_report_timestamp=$(cat "$last_battery_report_state" 2>/dev/null || echo '-1')
now=$(date +%s)

# Implement desired logic here. The example below for example only reports low
# battery every 24 hours.

if [ "$previous_report_timestamp" -eq -1 ] ||
  [ $((now - previous_report_timestamp)) -gt 86400 ]; then
  # Replace this with for example an HTTP call via curl, or xh
  echo "Reporting low battery: $battery_level_percentage%"

  echo "$now" >"$last_battery_report_state"
fi