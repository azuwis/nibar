#!/bin/sh

SPACES=$(/run/current-system/sw/bin/yabai -m query --spaces)
DISPLAYS=$(/run/current-system/sw/bin/yabai -m query --displays)

cat <<-EOF
{
  "spaces": $SPACES,
  "displays": $DISPLAYS
}
EOF
