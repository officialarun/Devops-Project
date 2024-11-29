#!/bin/bash

THRESHOLD=30

USAGE=$(df -h | grep ' /$' | awk '{print $5}' | awk '{print substr($0, 1, length($0)-1)}') # Removes '%'

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage critical: ${USAGE}% (Threshold: ${THRESHOLD}%)"
    exit 1 
else
    echo "Disk usage is under control: ${USAGE}% (Threshold: ${THRESHOLD}%)"
    exit 0
fi
