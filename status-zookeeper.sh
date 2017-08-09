#!/bin/bash

RUNNING="$(ps -eaf | grep java | grep zookeeper)"

source /root/.zookeeper/.env

source /usr/local/bin/setenv-zookeeper

if ! [[ -z "$RUNNING" ]]; then
  echo "running"
else
  echo "stopped"
fi
