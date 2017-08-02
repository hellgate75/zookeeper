#!/bin/bash

RUNNING="$($ZK_HOME/bin/zkServer.sh status|grep 'Mode:')"

if ! [[ -z "$RUNNING" ]]; then
  echo "running"
else
  echo "stopped"
fi
