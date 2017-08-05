FROM ubuntu:16.04

MAINTAINER Fabrizio Torelli <hellgate75@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ARG RUNLEVEL=1

ENV ZOOKEEPER_HOME=/usr/lib/zookeeper \
    ZOOKEEPER_PREFIX=/usr/lib/zookeeper \
    ZOO_LOG_DIR=/usr/lib/zookeeper/logs \
    ZOOKEEPER_DATA_FOLDER=/var/local/zookeeper \
    ZOOKEEPER_LOGS_FOLDER=/var/local/zookeeper-logs \
    ZOOKEEPER_SSL_FOLDER=/var/local/zookeeper-ssl \
    ZOOKEEPER_RELEASE=3.5.3-beta \
    ZOOKEEPER_CONFIGURATION_SCRIPT_URL= \
    ZOOKEEPER_CONFIGURATION_URL="" \
    ZOOKEEPER_PORT_ADDRESS="" \
    ZOOKEEPER_PORT=2181 \
    ZOOKEEPER_SECURE_PORT= \
    ZOOKEEPER_TICK_TIME=2000 \
    ZOOKEEPER_OUTSTANDING_LIMIT=1000 \
    ZOOKEEPER_PREALLOC_SIZE_KBS=65536 \
    ZOOKEEPER_SNAP_COUNT=100000 \
    ZOOKEEPER_SNAP_RETAIN_COUNT=3 \
    ZOOKEEPER_MAX_CLIENT_CONNECTIONS=60 \
    ZOOKEEPER_CONNECTIONS_TIMEOUT=60 \
    ZOOKEEPER_MIN_SESSION_TIMEOUT=4000 \
    ZOOKEEPER_MAX_SESSION_TIMEOUT=40000 \
    ZOOKEEPER_FSYNC_WARNING_THRD=1000 \
    ZOOKEEPER_SYNC_ENABLED=true \
    ZOOKEEPER_AUTOPURGE_INTERVAL=0 \
    ZK_STANDALONE_MODE=true \
    ZK_REPLICA_ELECTION_ALG=3 \
    ZK_REPLICA_INIT_LIMIT=5 \
    ZK_REPLICA_LEADER_SERVES=true \
    ZK_REPLICA_SYNC_LIMIT=2 \
    ZK_CLUSER_LEADER_ELECTION_TIMEOUT="" \
    ZK_CLUSER_SERVERS="" \
    ZK_CLUSER_SERVER_GROUPS="" \
    ZK_CLUSER_SERVER_WEIGHTS="" \
    ZK_SECURITY_ENABLEDs=false \
    ZK_SECURITY_DIGEST_AUTH_SUPER="" \
    ZK_SECURITY_X509_SSL_SUPER_USER="" \
    ZK_SECURITY_SSL_KEYSTORE_PASSWORD="" \
    ZK_SECURITY_SSL_TRUSTSTORE_PASSWORD="" \
    ZK_SECURITY_SSL_AUTH_PROVIDER="" \
    ZK_UNSAFE_FORCE_SYNC="false" \
    ZK_UNSAFE_JUTE_MAX_BUFFER="" \
    ZK_UNSAFE_SKIP_ACL="false" \
    ZK_UNSAFE_QUORUN_LIST_ALL_IPS="false" \
    ZOO_DATADIR_AUTOCREATE_DISABLE=0 \
    ZK_PERFORMANCE_NUM_SELECTOR_THREADS="" \
    ZK_PERFORMANCE_NUM_WORKER_THREADS="" \
    ZK_PERFORMANCE_NUM_COMMIT_WORKER_THREADS="" \
    ZK_TUNING_CHECK_INTERVAL_MILLIS=60000 \
    ZK_TUNING_CONTAINER_PER_MINUTE=10000 \
    ZK_ADMIN_SERVER_ENABLED=true \
    ZK_ADMIN_SERVER_ADDRESS="0.0.0.0" \
    ZK_ADMIN_SERVER_PORT=8080 \
    ZK_ADMIN_SERVER_IDLE_TIMEOUT=30000 \
    ZK_ADMIN_SERVER_COMMAND_URL="/commands" \
    PATH=$PATH:/usr/lib/zookeeper/bin


USER root

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install apt-utils \
    && apt-get -y install software-properties-common \
    && apt-get -y install wget curl htop git vim net-tools \
    && add-apt-repository -y -u ppa:webupd8team/java \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && echo -e "\n" | apt-get -y install oracle-java8-installer oracle-java8-set-default \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "head-zookeeper" >> /root/.bashrc \
    && echo ". setenv-zookeeper" >> /root/.bashrc

WORKDIR /root

RUN curl -sSL http://www-eu.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_RELEASE/zookeeper-$ZOOKEEPER_RELEASE.tar.gz | tar -x -C /usr/lib/ \
    && cd /usr/lib && ln -s zookeeper-* zookeeper \
    && mkdir -p $ZOOKEEPER_DATA_FOLDER \
    && mkdir -p ZOOKEEPER_LOGS_FOLDER \
    && mkdir -p $ZOOKEEPER_SSL_FOLDER \
    && mkdir -p $ZOOKEEPER_HOME/conf \
    && mkdir -p $ZOOKEEPER_HOME/logs \
    && mkdir -p /root/.zookeeper

#ADD zookeeper.cfg $ZOOKEEPER_HOME/conf/zoo.cfg
ADD zookeeper.cfg.standalone.template $ZOOKEEPER_HOME/conf/zoo.cfg.standalone.template
ADD zookeeper.cfg.replica.template $ZOOKEEPER_HOME/conf/zoo.cfg.replica.template

# update boot script
COPY docker-start-zookeeper.sh /usr/local/bin/docker-start-zookeeper
COPY start-zookeeper.sh /usr/local/bin/start-zookeeper
COPY status-zookeeper.sh /usr/local/bin/status-zookeeper
COPY stop-zookeeper.sh /usr/local/bin/stop-zookeeper
COPY head-zookeeper.sh /usr/local/bin/head-zookeeper
COPY configure-zookeeper.sh /usr/local/bin/configure-zookeeper
COPY load-zookeeper-data.sh /usr/local/bin/import-data-zookeeper
COPY get-zookeeper-node.sh /usr/local/bin/get-node-zookeeper
COPY set-zookeeper-node.sh /usr/local/bin/set-node-zookeeper
COPY default-setenv-zookeeper.sh /root/.zookeeper/default-setenv-zookeeper.sh
RUN chmod +x /usr/local/bin/*zookeeper

WORKDIR $ZOOKEEPER_HOME

EXPOSE 8080 2181 2182

VOLUME ["/var/local/zookeeper", "/var/local/zookeeper-logs", "/var/local/zookeeper-ssl"]

ENTRYPOINT ["docker-start-zookeeper"]
