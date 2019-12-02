#!/bin/bash

source ./prod-env.sh

echo "Starting app..."

# Start to run in background from shell.

# Foreground for testing and for systemd
_build/prod/rel/sms_scheduler/bin/sms_scheduler start
