#!/bin/bash

cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
ram=$(free -h | awk '/Mem:/ {print $3}')
gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)

echo "󰍛 ${cpu}% |   ${ram}B | 󰢮  ${gpu}%"
