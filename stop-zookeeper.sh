#!/bin/bash

RUNNING="$($ZK_HOME/bin/zkServer.sh status|grep 'Mode:')"

if ! [[ -z "$RUNNING" ]]; then
  cd /usr/lib/zookeeper

  $ZK_HOME/bin/zkServer.sh stop
else
  "Wiremock Server NOT running ..."
fi
