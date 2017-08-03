#!/bin/bash

RUNNING="$(ps -eaf | grep java | grep zookeeper)"

if ! [[ -z "$RUNNING" ]]; then
  $ZK_HOME/bin/zkServer.sh stop
else
  "Wiremock Server NOT running ..."
fi
