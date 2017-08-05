#!/bin/bash
if [[ $# -lt 1 ]]; then
  echo "Usage: get-node-zookeer [node-path]"
  exit 1
fi
DATA="$(zkCli.sh get $1 | grep -vi java | grep -vi connect| grep -vi watcher| grep -vi exception)"
echo "$(echo $DATA|sed 's/\n//g')"
