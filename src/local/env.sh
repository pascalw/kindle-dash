#!/usr/bin/env sh

# Export environment variables here
export WIFI_TEST_IP=${WIFI_TEST_IP:-1.1.1.1}

# export REFRESH_SCHEDULE=${REFRESH_SCHEDULE:-"/2 * * * *"}
# next-wakeup can't calculate next time from / syntax 

export REFRESH_SCHEDULE=${REFRESH_SCHEDULE:-"0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58 * * * *"}
export TIMEZONE=${TIMEZONE:-"Europe/London"}

# By default, partial screen updates are used to update the screen,
# to prevent the screen from flashing. After a few partial updates,
# the screen will start to look a bit distorted (due to e-ink ghosting).
# This number determines when a full refresh is triggered. By default it's
# triggered after 4 partial updates.
export FULL_DISPLAY_REFRESH_RATE=${FULL_DISPLAY_REFRESH_RATE:-4}

# When the time until the next wakeup is greater or equal to this number,
# the dashboard will not be refreshed anymore, but instead show a
# 'kindle is sleeping' screen. This can be useful if your schedule only runs
# during the day, for example.
export SLEEP_SCREEN_INTERVAL=3600

export LOW_BATTERY_REPORTING=${LOW_BATTERY_REPORTING:-false}
export LOW_BATTERY_THRESHOLD_PERCENT=10
