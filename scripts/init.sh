#!/bin/sh

for event in space_changed display_changed
do
  /run/current-system/sw/bin/yabai -m signal --add event=$event action='echo \{\"type\":\"WIDGET_WANTS_REFRESH\",\"payload\":\"nibar-spaces-jsx\"\} | websocat -E --origin http://127.0.0.1:41416 ws://127.0.0.1:41416' label=nibar_spaces_$event
done
for event in application_front_switched
do
  /run/current-system/sw/bin/yabai -m signal --add event=$event action='echo \{\"type\":\"WIDGET_WANTS_REFRESH\",\"payload\":\"nibar-windows-jsx\"\} | websocat -E --origin http://127.0.0.1:41416 ws://127.0.0.1:41416' label=nibar_windows_$event
done
