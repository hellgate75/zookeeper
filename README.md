<p align="center"><img src="https://github.com/hellgate75/zookeeper/raw/master/images/zookeper-logo.png" width="227"  height="395" /></p>

# Apache™ ZooKeeper Docker image


Docker Image for Apache™ Zookeper Single/Replica Node


### Introduction ###

Apache™ Zookeper is an effort to develop and maintain an open-source server which enables highly reliable distributed coordination.

Apache™ ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications. Each time they are implemented there is a lot of work that goes into fixing the bugs and race conditions that are inevitable. Because of the difficulty of implementing these kinds of services, applications initially usually skimp on them ,which make them brittle in the presence of change and difficult to manage. Even when done correctly, different implementations of these services lead to management complexity when the applications are deployed.


Here some more info on Apache™ Zookeeper :
http://zookeeper.apache.org/


### Goals ###

This docker image has been designed to be a test, development, integration, production environment for Apache™ Zookeeper single node and cluster instances.
*No warranties for production use.*



### Docker Image features ###

Here some information :

Volumes : /var/lib/zookeeper, /var/lib/zookeeper-logs, /var/lib/zookeeper-ssl

* `/var/lib/zookeeper` :

Zookeeper Data folder.

* `/var/lib/zookeeper-logs` :

Zookeeper transaction logs folder.

* `/var/lib/zookeeper-ssl`:

Zookeeper ssl certificates and related files (related to keystore and truststore).


Ports:

DEFAULT ports :

8080 2181 2182

* `8080`: Commands REST interface
* `2181`: Default (preferred) no-SSL port
* `2182`: Default (preferred) SSL port


### Docker Environment Variable ###

Here Zookeeper configuration acceleration variables :
* `ZOOKEEPER_CONFIGURATION_URL` : Url to zoo.cfg configuration file to be placed. Other single/replica node variables will be ignored(see [sample file](https://github.com/hellgate75/zookeeper/tree/master/sample/zoo-standalone.cfg)]).
* `ZOOKEEPER_CONFIGURATION_SCRIPT_URL` : Url to bash script file used for Apache™ Zookeper system variables configuration (see [sample script](https://github.com/hellgate75/zookeeper/tree/master/sample/zoo-standalone.bash)]).
* `ZOOKEEPER_CONFIGURATION_DATA_TARGZ_URL` : Url to data compressed tar gz file format for Apache™ Zookeper configuration provisioning. Node path separator character is `.`, eg: for node with path `/myserver/myfunction`, file name will be `myserver.myfunction` and file content will represent node value (see [samples](https://github.com/hellgate75/zookeeper/tree/master/sample)]).

For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


Here Apache™ Zookeeper single mode container environment variables :

* `ZOOKEEPER_PORT_ADDRESS` : The address (ipv4, ipv6 or hostname) to listen for client connections; that is, the address that clients attempt to connect to. This is optional, by default we bind in such a way that any connection to the clientPort for any address/interface/nic on the server will be accepted. Leave empty to disable (default : "" - ignored)
* `ZOOKEEPER_PORT` :  The port to listen for client connections; that is, the port that clients attempt to connect to. Make empty to disable (default : 2181)
* `ZOOKEEPER_SECURE_PORT` : The port to listen on for secure client connections using SSL. clientPort specifies the port for plaintext connections while secureClientPort specifies the port for SSL connections. Specifying both enables mixed-mode while omitting either will disable that mode. Note that SSL feature will be enabled when user plugs-in zookeeper.serverCnxnFactory, zookeeper.clientCnxnSocket as Netty Leave empty to disable (default : "" - preferred 2182)
* `ZOOKEEPER_TICK_TIME` : The length of a single tick, which is the basic time unit used by ZooKeeper, as measured in milliseconds. It is used to regulate heartbeats, and timeouts. For example, the minimum session timeout will be two ticks (default : 2000)
* `ZOOKEEPER_OUTSTANDING_LIMIT` : Clients can submit requests faster than ZooKeeper can process them, especially if there are a lot of clients. To prevent ZooKeeper from running out of memory due to queued requests, ZooKeeper will throttle clients so that there is no more than globalOutstandingLimit outstanding requests in the system (default : 1000)
* `ZOOKEEPER_PREALLOC_SIZE_KBS` : To avoid seeks ZooKeeper allocates space in the transaction log file in blocks of preAllocSize kilobytes. The default block size is 64M. One reason for changing the size of the blocks is to reduce the block size if snapshots are taken more often. (Also, see ZOOKEEPER_SNAP_COUNT) (default : 65536)
* `ZOOKEEPER_SNAP_COUNT` : ZooKeeper logs transactions to a transaction log. After snapCount transactions are written to a log file a snapshot is started and a new transaction log file is created (default : 100000)
* `ZOOKEEPER_SNAP_RETAIN_COUNT` : When enabled, ZooKeeper auto purge feature retains the ZOOKEEPER_SNAP_RETAIN_COUNT most recent snapshots and the corresponding transaction logs in the dataDir and dataLogDir respectively and deletes the rest. Defaults to 3. Minimum value is 3 (default : 3)
* `ZOOKEEPER_MAX_CLIENT_CONNECTIONS` : Limits the number of concurrent connections (at the socket level) that a single client, identified by IP address, may make to a single member of the ZooKeeper ensemble. This is used to prevent certain classes of DoS attacks, including file descriptor exhaustion. The default is 60. Setting this to 0 entirely removes the limit on concurrent connections (default : 60)
* `ZOOKEEPER_MIN_SESSION_TIMEOUT` : The minimum session timeout in milliseconds that the server will allow the client to negotiate. Defaults to 2 times the tickTime (default : 4000)
* `ZOOKEEPER_MAX_SESSION_TIMEOUT` : The maximum session timeout in milliseconds that the server will allow the client to negotiate. Defaults to 20 times the tickTime (default : 40000)
* `ZOOKEEPER_FSYNC_WARNING_THRD` : A warning message will be output to the log whenever an fsync in the Transactional Log (WAL) takes longer than this value (default : 1000)
* `ZOOKEEPER_SYNC_ENABLED` : The observers now log transaction and write snapshot to disk by default like the participants. This reduces the recovery time of the observers on restart. Set to "false" to disable this feature (default : true)
* `ZOOKEEPER_AUTOPURGE_INTERVAL` : The time interval in hours for which the purge task has to be triggered. Set to a positive integer (1 and above) to enable the auto purging (default : 0)
* `ZK_REPLICA_INIT_LIMIT` : Amount of time, in ticks (see ZOOKEEPER_TICK_TIME), to allow followers to connect and sync to a leader. Increased this value as needed, if the amount of data managed by ZooKeeper is large (default : 5)
* `ZK_REPLICA_SYNC_LIMIT` : Amount of time, in ticks (see ZOOKEEPER_TICK_TIME), to allow followers to sync with ZooKeeper. If followers fall too far behind a leader, they will be dropped (default : 2)

For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


Here extra information for Apache™ Zookeeper replica mode container environment variables :

* `ZK_STANDALONE_MODE` : (true/false) When set to false, a single server can be started in replicated mode, a lone participant can run with observers, and a cluster can reconfigure down to one node, and up from one node. The default is true for backwards compatibility. It can be set using QuorumPeerConfig's setStandaloneEnabled method (default : true)
* `ZK_REPLICA_ELECTION_ALG` : Election implementation to use. A value of "0" corresponds to the original UDP-based version, "1" corresponds to the non-authenticated UDP-based version of fast leader election, "2" corresponds to the authenticated UDP-based version of fast leader election, and "3" corresponds to TCP-based version of fast leader election (default : 3)
* `ZK_REPLICA_LEADER_SERVES` :  (true/false) Leader accepts client connections. Default value is "yes". The leader machine coordinates updates. For higher update throughput at thes slight expense of read throughput the leader can be configured to not accept clients and focus on coordination. The default to this option is yes, which means that a leader will accept client connection (default : true)
* `ZK_CLUSER_LEADER_ELECTION_TIMEOUT` : Sets the timeout value for opening connections for leader election notifications. Only applicable if you are using ZK_REPLICA_ELECTION_ALG 3. (default : "")
* `ZK_CLUSER_SERVERS` : (';' separated server information in format `[hostname]:nnnnn[:nnnnn],...`, e.g.: `mynode1:2181;mynode2:2181:2182`) Servers making up the ZooKeeper ensemble. When the server starts up, it determines which server it is by looking for the file myid in the data directory. That file contains the server number, in ASCII, and it should match x in server.x in the left hand side of this setting. The list of servers that make up ZooKeeper servers that is used by the clients must match the list of ZooKeeper servers that each ZooKeeper server has. There are two port numbers nnnnn. The first followers use to connect to the leader, and the second is for leader election. The leader election port is only necessary if electionAlg is 1, 2, or 3 (default). If electionAlg is 0, then the second port is not necessary. If you want to test multiple servers on a single machine, then different ports can be used for each server (default : "")
* `ZK_CLUSER_SERVER_GROUPS` : (';' separated group information in format `nnnnn[:nnnnn],...`, e.g.: `2181;2181:2182`) Enables a hierarchical quorum construction."x" is a group identifier and the numbers following the "=" sign correspond to server identifiers. The left-hand side of the assignment is a colon-separated list of server identifiers. Note that groups must be disjoint and the union of all groups must be the ZooKeeper ensemble (default : "")
* `ZK_CLUSER_SERVER_WEIGHTS` : (';' separated server weight information in format `nnnnn,...`, e.g.: `1;1`)  Used along with "group", it assigns a weight to a server when forming quorums. Such a value corresponds to the weight of a server when voting. There are a few parts of ZooKeeper that require voting such as leader election and the atomic broadcast protocol. By default the weight of server is 1. If the configuration defines groups, but not weights, then a value of 1 will be assigned to all servers (default : "")


For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


Here extra information for Apache™ Zookeeper secure connection (cross standalone/replica modes) environment variables :
* `ZK_SECURITY_ENABLED` : (true/false) Enable or disable security (default : false)
* `ZK_SECURITY_DIGEST_AUTH_SUPER` : Enables a ZooKeeper ensemble administrator to access the znode hierarchy as a "super" user. In particular no ACL checking occurs for a user authenticated as super.org.apache.zookeeper.server.auth.DigestAuthenticationProvider can be used to generate the superDigest, call it with one parameter of "super:<password>". Provide the generated "super:<data>" as the system property value when starting each server of the ensemble. When authenticating to a ZooKeeper server (from a ZooKeeper client) pass a scheme of "digest" and authdata of "super:<password>". Note that digest auth passes the authdata in plaintext to the server, it would be prudent to use this authentication method only on localhost (not over the network) or over an encrypted connection (default : "")
* `ZK_SECURITY_X509_SSL_SUPER_USER` : The SSL-backed way to enable a ZooKeeper ensemble administrator to access the znode hierarchy as a "super" user. When this parameter is set to an X500 principal name, only an authenticated client with that principal will be able to bypass ACL checking and have full privileges to all znodes (default : "")
* `ZK_SECURITY_SSL_KEYSTORE_PASSWORD` : Enable the file path (/var/lib/zookeeper-ssl) to a JKS containing the local credentials to be used for SSL connections, using passed password to unlock the file (default : "")
* `ZK_SECURITY_SSL_TRUSTSTORE_PASSWORD` :  Enable the file path (/var/lib/zookeeper-ssl) to a JKS containing the remote credentials to be used for SSL connections, using passed password to unlock the file (default : "")
* `ZK_SECURITY_SSL_AUTH_PROVIDER` : Specifies a subclass of org.apache.zookeeper.auth.X509AuthenticationProvider to use for secure client authentication. This is useful in certificate key infrastructures that do not use JKS. It may be necessary to extend javax.net.ssl.X509KeyManager and javax.net.ssl.X509TrustManager to get the desired behavior from the SSL stack. To configure the ZooKeeper server to use the custom provider for authentication, choose a scheme name for the custom AuthenticationProvider and set the property zookeeper.authProvider.[scheme] to the fully-qualified class name of the custom implementation. This will load the provider into the ProviderRegistry. Then set this property zookeeper.ssl.authProvider=[scheme] and that provider will be used for secure authentication (default : "")


For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


Here extra information for Apache™ Zookeeper usafe options (cross standalone/replica modes) environment variables :
* `ZK_UNSAFE_FORCE_SYNC` : (true/false) Requires updates to be synced to media of the transaction log before finishing processing the update. If this option is set to no, ZooKeeper will not require updates to be synced to the media (default : false)
* `ZK_UNSAFE_JUTE_MAX_BUFFER` : This option can only be set as a Java system property. There is no zookeeper prefix on it. It specifies the maximum size of the data that can be stored in a znode. The default is 0xfffff, or just under 1M. If this option is changed, the system property must be set on all servers and clients otherwise problems will arise. This is really a sanity check. ZooKeeper is designed to store data on the order of kilobytes in size (default : "")
* `ZK_UNSAFE_SKIP_ACL` : (true/false) Skips ACL checks. This results in a boost in throughput, but opens up full access to the data tree to everyone (default : "false")
* `ZK_UNSAFE_QUORUN_LIST_ALL_IPS` : (true/false) When set to true the ZooKeeper server will listen for connections from its peers on all available IP addresses, and not only the address configured in the server list of the configuration file. It affects the connections handling the ZAB protocol and the Fast Leader Election protocol (default : "false")


For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


Here extra information for Apache™ Zookeeper performance and tuning (cross standalone/replica modes) environment variables :
* `ZK_PERFORMANCE_NUM_SELECTOR_THREADS` : Number of NIO selector threads. At least 1 selector thread required. It is recommended to use more than one selector for large numbers of client connections. (default: "" - sqrt( number of cpu cores / 2 ) )
* `ZK_PERFORMANCE_NUM_WORKER_THREADS` : Number of NIO worker threads. If configured with 0 worker threads, the selector threads do the socket I/O directly. (default: "" - 2 times the number of cpu cores)
* `ZK_PERFORMANCE_NUM_COMMIT_WORKER_THREADS` : Number of Commit Processor worker threads. If configured with 0 worker threads, the main thread will process the request directly (default: "" - the number of cpu cores)
* `ZK_TUNING_CHECK_INTERVAL_MILLIS` : The time interval in milliseconds for each check of candidate container nodes (default: 60000)
* `ZK_TUNING_CONTAINER_PER_MINUTE` : The maximum number of container nodes that can be deleted per minute. This prevents herding during container deletion (default: 10000).


For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)

Here extra information for Apache™ Zookeeper admin server (cross standalone/replica modes) environment variables :
* `ZK_ADMIN_SERVER_ENABLED` : Set to "false" to disable the AdminServer.  (default: true).
* `ZK_ADMIN_SERVER_ADDRESS` : The address the embedded Jetty server listens on.  (default: 0.0.0.0)
* `ZK_ADMIN_SERVER_PORT` : The port the embedded Jetty server listens on.  (default: 8080)
* `ZK_ADMIN_SERVER_IDLE_TIMEOUT` : Set the maximum idle time in milliseconds that a connection can wait before sending or receiving data (default: 30000 [ms])
* `ZK_ADMIN_SERVER_COMMAND_URL` : The URL for listing and issuing commands relative to the root URL. (default: /commands)


For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


Here other variables for Apache™ Zookeeper commons (cross standalone/replica modes) environment variables :
* `ZOO_DATADIR_AUTOCREATE_DISABLE` : (0, 1) The default behavior of a ZooKeeper server is to automatically create the data directory (specified in the configuration file) when started if that directory does not already exist. This can be inconvenient and even dangerous in some cases. Take the case where a configuration change is made to a running server, wherein the dataDir parameter is accidentally changed. When the ZooKeeper server is restarted it will create this non-existent directory and begin serving - with an empty znode namespace. This scenario can result in an effective "split brain" situation (i.e. data in both the new invalid directory and the original valid data store). As such is would be good to have an option to turn off this autocreate behavior. In general for production environments this should be done, unfortunately however the default legacy behavior cannot be changed at this point and therefore this must be done on a case by case basis. This is left to users and to packagers of ZooKeeper distributions (default: 0 - autocrae enabled)


For more information about values : [Apache™ Zookeeper Configuration](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)


### Sample command ###

Here a sample command to run Apache™ Zookeeper container:

```bash
docker run -d -p 2181:2181 -p 2182:2182 -v my/data/dir:/var/lib/zookeeper my/trans/logs/dir:/var/lib/zk-transaction-logs --name my-zookeeper hellgate75/zookeeper:latest
```


### Test Zookeeper via client connection ###

In order to access to docker container :
```bash
    docker exec -it my-zookeeper bash
```

The open client connection :
```bash
    zkCli.sh -server 127.0.0.1:2181
```
Simple test steps into zookeeper client shell :
```bash
    ls /
    create /zk_test my_data
    ls /
    get /zk_test
    set /zk_test junk
    delete /zk_test
    ls /
```

Get service action should return data like :
```bash
    my_data
    cZxid = 5
    ctime = Fri Jun 05 13:57:06 PDT 2009
    mZxid = 5
    mtime = Fri Jun 05 13:57:06 PDT 2009
    pZxid = 5
    cversion = 0
    dataVersion = 0
    aclVersion = 0
    ephemeralOwner = 0
    dataLength = 7
    numChildren = 0
```

Get service action, after junk, should return data like :
```bash
    cZxid = 5
    ctime = Fri Jun 05 13:57:06 PDT 2009
    mZxid = 6
    mtime = Fri Jun 05 14:01:52 PDT 2009
    pZxid = 5
    cversion = 0
    dataVersion = 1
    aclVersion = 0
    ephemeralOwner = 0
    dataLength = 4
    numChildren = 0
    [zkshell: 15] get /zk_test
    junk
    cZxid = 5
    ctime = Fri Jun 05 13:57:06 PDT 2009
    mZxid = 6
    mtime = Fri Jun 05 14:01:52 PDT 2009
    pZxid = 5
    cversion = 0
    dataVersion = 1
    aclVersion = 0
    ephemeralOwner = 0
    dataLength = 4
    numChildren = 0
```

For more info refer to [Apache™ Zookeeper Started](http://zookeeper.apache.org/doc/trunk/zookeeperStarted.html)


### Custom commands

In this image are provided following custom commands :

* `get-node-zookeeper` : Retrieve Apache™ Zookeeper node value
* `set-node-zookeeper` : Set Apache™ Zookeeper node value


### License ###

[LGPL 3](https://github.com/hellgate75/zookeeper/tree/master/LICENSE)
