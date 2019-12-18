#!/bin/bash
port=28017
confFile='mongo_28017'
password='123456'

yum install libcurl openssl wget net-tools -y

#wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.16.tgz

tar xf ~/Downloads/mongodb-linux-x86_64-* -C /opt/

ln -s /opt/mongodb-linux-x86_64-* /opt/mongodb

mkdir -p /opt/${confFile}/{conf,logs,pid}

mkdir -p /data/${confFile}

localIP=$(ip addr|grep eth0|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "add:")

localip=${localIP%/*}

echo 'systemLog:
  destination: file #Mongodb 日志输出的目的地，指定一个 file 或者 syslog，如果指定 file，必须指定
  logAppend: true #当实例重启时，不创建新的日志文件，在老的日志文件末尾继续添加
  path: /opt/'${confFile}'/logs/mongodb.log #日志路径
storage:
  journal: #回滚日志
    enabled: true
  dbPath: /data/'${confFile}' #数据存储目录
  directoryPerDB: true #默认 false，不适用 inmemory engine
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1 #将用于所有数据缓存的最大小
      directoryForIndexes: true #默认 false 索引集合 storage.dbPath 存储在数据单独子目录
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true
processManagement: #使用处理系统守护进程的控制处理
  fork: true #后台运行
  pidFilePath: /opt/'${confFile}'/pid/mongod.pid #创建 pid 文件
net:
  port: '${port}' #监听端口
  bindIp: 127.0.0.1,'$localip' #绑定 ip
' > /opt/${confFile}/conf/mongodb.conf

netstat -luntp |grep mongo

#echo "export PATH=/opt/mongodb/bin:\$PATH" >> /etc/profile
#source /etc/profile

#mongod -f /opt/mongo_27017/conf/mongodb.conf --shutdown

useradd mongo

echo ${password}|passwd --stdin mongo

chown -R mongo:mongo /data/${confFile}/  /opt/${confFile}

#echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
#echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
#
#chmod +x /etc/rc.d/rc.local
#echo 'echo "never" > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.d/rc.local
#echo 'echo "never" > /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.d/rc.local
#
#su - mongo
#
#confFile='mongo_28017'
#
#mongod -f /opt/${confFile}/conf/mongodb.conf
