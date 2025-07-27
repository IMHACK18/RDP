#!/bin/bash

while true
do
  cd RDP || exit 1
  
  # Start rdp3.sh and capture PID
  sudo sh rdp3.sh <<EOF | tee rdp_log.txt &
  
EOF
  PID=$!

  # Monitor log until "Finished Successfully" appears
  tail -f rdp_log.txt | while read line; do
    echo "$line"
    if [[ "$line" == *"Finished Successfully"* ]]; then
      echo "Detected finish message. Killing rdp3.sh..."
      kill $PID 2>/dev/null
      pkill -f rdp3.sh 2>/dev/null
      break
    fi
  done

  # Wait 30 minutes before running again
  echo "Sleeping for 30 minutes..."
  sleep 1800
done
