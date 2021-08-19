#!/bin/sh

DATE_TIME="$(date +"%a %m-%d %H:%M")"

BATTERY="$(pmset -g batt)"
BATTERY_PERCENTAGE="${BATTERY%\%*}"
BATTERY_PERCENTAGE="${BATTERY_PERCENTAGE##*	}"
BATTERY_STATUS="${BATTERY#*\'}"
BATTERY_STATUS="${BATTERY_STATUS%% *}"

BATTERY_CHARGING="false"
if [ "$BATTERY_STATUS" = "AC" ]
then
  BATTERY_CHARGING="true"
fi

LOAD_AVERAGE="$(sysctl -n vm.loadavg)"
LOAD_AVERAGE="${LOAD_AVERAGE% * * *}"
LOAD_AVERAGE="${LOAD_AVERAGE#* }"

WIFI="$(networksetup -getairportnetwork en0)"
WIFI_SSID="${WIFI#*: }"

WIFI_STATUS="active"
if [ "$WIFI_SSID" = "$WIFI" ]
then
  WIFI_SSID=""
  WIFI_STATUS="inactive"
fi

cat <<-EOF
{
  "datetime": {
    "datetime": "$DATE_TIME"
  },
  "battery": {
    "percentage": $BATTERY_PERCENTAGE,
    "charging": $BATTERY_CHARGING
  },
  "cpu": {
    "loadAverage": $LOAD_AVERAGE
  },
  "wifi": {
    "status": "$WIFI_STATUS",
    "ssid": "$WIFI_SSID"
  }
}
EOF
