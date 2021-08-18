#!/bin/sh

WINDOWS=$(/run/current-system/sw/bin/yabai -m query --windows --space mouse)

cat <<-EOF
{
  "windows": $WINDOWS
}
EOF
