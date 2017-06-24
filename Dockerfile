FROM hellgate75/ubuntu-base:16.04

MAINTAINER Fabrizio Torelli (hellgate75@gmail.com)

ARG DEBIAN_FRONTEND=noninteractive
ARG RUNLEVEL=1

ENV ZOOKEEPER_HOME=/usr/local/zookeeper \
    ZOOKEEPER_PREFIX=/usr/local/zookeeper \
    ZOO_LOG_DIR=/usr/local/zookeeper/logs \
    ZOOKEEPER_DATA_FOLDER=/var/lib/zookeeper \
    ZOOKEEPER_LOGS_FOLDER=/var/lib/zk-transaction-logs \
    ZOOKEEPER_SSL_FOLDER=/var/lib/zookeeper-ssl \
    ZOOKEEPER_RELEASE=3.5.2-alpha \
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
    PATH=$PATH:/usr/local/zookeeper/bin


USER root

#support for Hadoop 2.6.0
RUN curl -s http://www-eu.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_RELEASE/zookeeper-$ZOOKEEPER_RELEASE.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s zookeeper-$ZOOKEEPER_RELEASE zookeeper
RUN mkdir -p $ZOOKEEPER_DATA_FOLDER && mkdir -p ZOOKEEPER_LOGS_FOLDER && mkdir -p $ZOOKEEPER_SSL_FOLDER && mkdir -p $ZOOKEEPER_HOME/conf && mkdir -p $ZOOKEEPER_HOME/logs

#ADD zookeeper.cfg $ZOOKEEPER_HOME/conf/zoo.cfg
ADD zookeeper.cfg.standalone.template $ZOOKEEPER_HOME/conf/zoo.cfg.standalone.template
ADD zookeeper.cfg.replica.template $ZOOKEEPER_HOME/conf/zoo.cfg.replica.template

# update boot script
COPY docker-start-zookeeper.sh /usr/local/bin/docker-start-zookeeper
RUN chmod +x /usr/local/bin/docker-start-zookeeper

WORKDIR /usr/local/zookeeper

EXPOSE 8080 2181 2182

VOLUME ["/var/lib/zookeeper", "/var/lib/zk-transaction-logs", "/var/lib/zookeeper-ssl"]

ENTRYPOINT ["docker-start-zookeeper"]
