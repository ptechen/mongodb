#!/bin/bash

mkdir -p /opt/mongo_2801{7,8,9}/{conf,log,pid}

mkdir -p /data/mongo_2801{7,8,9}

chown -R mongo:mongo /opt/mongo_2801{7,8,9} /data/mongo_2801{7,8,9}

echo 'systemLog:
  destination: file
  logAppend: true
  path: /opt/mongo_28017/log/mongodb.log

storage:
  journal:
    enabled: true
  dbPath: /data/mongo_28017
  directoryPerDB: true
  wiredTiger:
     engineConfig:
        cacheSizeGB: 0.5
        directoryForIndexes: true
     collectionConfig:
        blockCompressor: zlib
     indexConfig:
        prefixCompression: true

processManagement:
  fork: true
  pidFilePath: /opt/mongo_28017/pid/mongod.pid

net:
  port: 28017
  bindIp: 127.0.0.1,10.4.7.60

replication:
   oplogSizeMB: 1024
   replSetName: dba
' > /opt/mongo_28017/conf/mongo_28017.conf

echo 'systemLog:
  destination: file
  logAppend: true
  path: /opt/mongo_28018/log/mongodb.log

storage:
  journal:
    enabled: true
  dbPath: /data/mongo_28018
  directoryPerDB: true
  wiredTiger:
     engineConfig:
        cacheSizeGB: 0.5
        directoryForIndexes: true
     collectionConfig:
        blockCompressor: zlib
     indexConfig:
        prefixCompression: true

processManagement:
  fork: true
  pidFilePath: /opt/mongo_28018/pid/mongod.pid

net:
  port: 28018
  bindIp: 127.0.0.1,10.4.7.60

replication:
   oplogSizeMB: 1024
   replSetName: dba
' > /opt/mongo_28018/conf/mongo_28018.conf

echo 'systemLog:
  destination: file
  logAppend: true
  path: /opt/mongo_28019/log/mongodb.log

storage:
  journal:
    enabled: true
  dbPath: /data/mongo_28019
  directoryPerDB: true
  wiredTiger:
     engineConfig:
        cacheSizeGB: 0.5
        directoryForIndexes: true
     collectionConfig:
        blockCompressor: zlib
     indexConfig:
        prefixCompression: true

processManagement:
  fork: true
  pidFilePath: /opt/mongo_28019/pid/mongod.pid

net:
  port: 28019
  bindIp: 127.0.0.1,10.4.7.60

replication:
   oplogSizeMB: 1024
   replSetName: dba
' > /opt/mongo_28019/conf/mongo_28019.conf

#sed -i 's#28017#28018#g' /opt/mongo_28018/conf/mongo_28018.conf
#sed -i 's#28017#28019#g' /opt/mongo_28019/conf/mongo_28019.conf

mongod -f /opt/mongo_28017/conf/mongo_28017.conf
mongod -f /opt/mongo_28018/conf/mongo_28018.conf
mongod -f /opt/mongo_28019/conf/mongo_28019.conf
