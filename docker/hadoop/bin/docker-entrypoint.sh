#!/bin/bash

: ${HADOOP_HOME:=/opt/hadoop}

if [[ -z "${NODE_TYPE}" ]]; then
  echo "ENV NODE_TYPE not set"
  exit -1
fi

# . $HADOOP_HOME/etc/hadoop/hadoop-env.sh


# # installing libraries if any - (resource urls added comma separated to the ACP system variable)
# cd $HADOOP_HOME/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

if [[ "${NODE_TYPE}" =~ "hadoop-master" ]]; then
  # $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive
  #$HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive
  sed -i s/hadoop-master-svc:9000/0.0.0.0:9000/ $HADOOP_HOME/etc/hadoop/core-site.xml
  $HADOOP_HOME/sbin/hadoop-daemon.sh start namenode

  sed -i s/hadoop-master-svc/0.0.0.0/ $HADOOP_HOME/etc/hadoop/yarn-site.xml
  $HADOOP_HOME/sbin/yarn-daemon.sh start resourcemanager
fi

if [[ "${NODE_TYPE}" =~ "hadoop-slave" ]]; then
  $HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
  sed -i '/<\/configuration>/d' $HADOOP_HOME/etc/hadoop/yarn-site.xml
  cat >> $HADOOP_HOME/etc/hadoop/yarn-site.xml <<- EOM
  <property>
    <name>yarn.nodemanager.resource.memory-mb</name>
    <value>${MY_MEM_LIMIT:-2048}</value>
  </property>

  <property>
    <name>yarn.nodemanager.resource.cpu-vcores</name>
    <value>${MY_CPU_LIMIT:-2}</value>
  </property>
EOM
  echo '</configuration>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
  $HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
fi

if [[ $1 == "-d" ]]; then
  until find ${HADOOP_HOME}/logs -mmin -1 | egrep -q '.*'; echo "`date`: Waiting for logs..." ; do sleep 2 ; done
  tail -F ${HADOOP_HOME}/logs/* &
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
