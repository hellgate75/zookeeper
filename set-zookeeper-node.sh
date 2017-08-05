#!/bin/bash
if [[ $# -lt 2 ]]; then
  echo "Usage: set-node-zookeer [node-path] [value]"
  exit 1
fi
DATA="$(zkCli.sh get $1 | grep -vi java | grep -vi connect| grep -vi watcher| grep -vi exception)"
if [[ -z "$DATA" ]]; then
  zkCli.sh create "$1"
fi
zkCli.sh set "$1" "$2"
