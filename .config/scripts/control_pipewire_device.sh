#!/bin/bash

# Check if the target string is provided as an argument
if [ $# -eq 0 ]; then
  echo "Error: Target string not provided."
  echo "Usage: $0 <target_string>"
  exit 1
fi

# Extract the target string from the command-line argument
target_string="$1"

# Run the PipeWire command and store the output in a variable
pw_output=$(wpctl status)

# Use sed to extract the lines between "Sinks:" and the line containing the target string
filtered_lines=$(echo "$pw_output" | sed -n "/Sinks:/,/*$target_string/p")

# Use awk to extract the sink ID and sink name from the "sinks" section
sink_info=$(echo "$pw_output" | awk -v target="$target_string" '
    /Sinks:/ { in_sinks=1; next }
    in_sinks && index($0, target) {
        split($0, parts, ".")
        gsub(/[^0-9]/, "", parts[1])
        sub(/^\s+\*/, "", parts[2])  # Remove leading asterisk, if present
        print parts[1], parts[2]
        exit
    }
')

# Check if the sink is found or not
if [ -z "$sink_info" ]; then
  echo "Error: Sink not found with the specified target string: $target_string"
  exit 1
fi

# Extract sink ID and sink name from the sink_info variable
sink_id=$(echo "$sink_info" | awk '{print $1}')
sink_name=$(echo "$sink_info" | awk '{$1=""; print $0}' | sed -e 's/^[[:space:]]*//')

# Use it
wpctl set-default $sink_id
notify-send "Changed pipewire default sink" "$sink_name"
