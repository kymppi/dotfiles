#!/bin/sh
output="$(headsetcontrol -b -c)"

case "$output" in
  -1)
    output="Charging"
    ;;
  -2)
    output="Disconnected"
    ;;
    *)
    output="$output%"
    ;; 
esac

echo "Headphones: $output"
