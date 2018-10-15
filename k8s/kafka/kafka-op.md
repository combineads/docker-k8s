zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181



bin/kafka-topics.sh --zookeeper zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181 --delete  --topic meetup-raw-rsvps 





bin/kafka-topics.sh --zookeeper zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181 --create  --topic meetup-raw-rsvps --partitions 1 --replication-factor 1


bin/kafka-topics.sh --zookeeper zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181 --list


bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --topic meetup-raw-rsvps --zookeeper zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181
    --group test_group

bin/kafka-console-consumer.sh --zookeeper zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181 --from-beginning --topic meetup-raw-rsvps


bin/kafka-console-consumer.sh --bootstrap-server kafka-0.kafka-svc.default.svc.cluster.local:9092,kafka-1.kafka-svc.default.svc.cluster.local:9092,kafka-2.kafka-svc.default.svc.cluster.local:9092  --topic meetup-raw-rsvps --from-beginning  




./zookeeper-shell.sh zookeeper-0.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-1.zookeeper-svc.default.svc.cluster.local:2181,zookeeper-2.zookeeper-svc.default.svc.cluster.local:2181

ls  /brokers/topics

rmr /brokers/topics/meetup-raw-rsvps
rmr /brokers/topics/meetup-raw-rsvps-2