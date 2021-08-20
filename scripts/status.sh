#!/bin/bash

DATE_TIME="$(date +"%a %m-%d %H:%M")"

BATTERY="$(pmset -g batt)"
BATTERY_PERCENTAGE="${BATTERY%\%*}"
BATTERY_PERCENTAGE="${BATTERY_PERCENTAGE##*	}"
read -r _ _ _ BATTERY_STATUS _ <<< "$BATTERY"
BATTERY_CHARGING="false"
if [ "$BATTERY_STATUS" = "'AC" ]
then
  BATTERY_CHARGING="true"
fi

LOAD_AVERAGE="$(sysctl -n vm.loadavg)"
read -r _ _ LOAD_AVERAGE _ <<< "$LOAD_AVERAGE"

WIFI="$(networksetup -getairportnetwork en0)"
read -r _ _ TEST WIFI_SSID <<< "$WIFI"

if [ "$TEST" = "Network:" ]
then
  WIFI_STATUS="active"
else
  WIFI_SSID=""
  WIFI_STATUS="inactive"
fi

NETWORK="$(netstat -ibn -I en0)"
NETWORK="${NETWORK##*en0}"
read -r _ _ _ _ _ IBYTES _ _ OBYTES _ <<< "${NETWORK}"

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
  },
  "network": {
    "ibytes": $IBYTES,
    "obytes": $OBYTES
  }
}
EOF
