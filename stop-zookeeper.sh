#!/bin/bash

RUNNING="$(ps -eaf | grep java | grep zookeeper)"

source /root/.zookeeper/.env

source /usr/local/bin/setenv-zookeeper

if ! [[ -z "$RUNNING" ]]; then
  zkServer.sh stop
else
  "Wiremock Server NOT running ..."
fi
