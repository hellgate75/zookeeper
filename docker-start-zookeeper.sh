#!/usr/bin/env bash

cd $ZOOKEEPER_HOME

ZOOKERPER_ACTIVE="$(ps -eaf | grep java | grep zookeeper)"

if [[ -z "$ZOOKERPER_ACTIVE" ]]; then
  echo "Starting Apache Zookeeper v. $ZOOKEEPER_RELEASE ..."
  if ! [[ -e /root/.zookeeper_configured ]]; then
    export CONFIGURATION=false
    configure-zookeeper
    touch /root/.zookeeper_configured
  fi

  start-zookeeper

  import-data-zookeeper

  CMD=${1:-""}
  if [[ "$CMD" == "-s" ]]; then
    echo "WARNING: SHELL COMMAND FOR A NOT RUNNING Apache Zookepeer Container!!"
  fi

  echo "Logging ZooKeeper ..."
  head-zookeeper
  tail -f $ZOOKEEPER_HOME/logs/zookeeper--server-*.out

  echo -e "\nApache Zookeeper v. $ZOOKEEPER_RELEASE ports : \n"
  netstat -anp

else
  echo "Apache Zookeeper aleady running ..."
  CMD=${1:-""}
  if [[ "$CMD" != "-s" ]]; then
    echo "WARNING: NO SHELL COMMAND FOR A RUNNING Apache Zookepeer Container!!"
  fi

  echo -e "\nApache Zookeeper v. $ZOOKEEPER_RELEASE ports : \n"
  netstat -anp

fi

CMD=${1:-"exit 0"}
if [[ "$CMD" == "-s" ]];
then
  echo "Running Apache Zookeeper v. $ZOOKEEPER_RELEASE shell command : $* ..."
  /bin/bash -c "$*"
else
  head-zookeeper
  echo " Apache Zookeeper v. $ZOOKEEPER_RELEASE : Waiting forever ..."
  tail -f /dev/null
fi
