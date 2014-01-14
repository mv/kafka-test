# What


Kafka and Zookeeper standalone box for tests.



# install

    sudo su -
    cd /vagrant
    chef-apply ./zookeeper.rb
    chef-apply ./kafka.rb


# Zookeeper

    # details
    rpm -ql zookeeper

    # using
    /etc/init.d/zookeeper start
    /etc/init.d/zookeeper stop
    /etc/init.d/zookeeper status

    tail -f /var/log/zookeeper/zookeeper.log


# Kafka

Kafka is an rpm installed in _*/opt/kafka*_

    # details
    rpm -ql kafka

    # using
    /etc/init.d/kafka start
    /etc/init.d/kafka stop
    /etc/init.d/kafka status

    # main log
    tail -f /var/log/kafka/server.log



# Tests


    ## Setup (using Terminal 1)
    /opt/kafka/bin/kafka-create-topic.sh --zookeeper localhost:2181 --replica 1 --partition 1 --topic test
    /opt/kafka/bin/kafka-create-topic.sh --zookeeper localhost:2181 --replica 1 --partition 1 --topic test2
    /opt/kafka/bin/kafka-create-topic.sh --zookeeper localhost:2181 --replica 1 --partition 1 --topic mytest

    /opt/kafka/bin/kafka-list-topic.sh --zookeeper localhost:2181


    ## Producer  (using Terminal 1)
    random_string | kafka-console-producer.sh --broker-list localhost:9092 --topic test > /dev/null

    ## Consumer  (using another Terminal)
    sudo su -
    kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning


# Reinstalling everything

    sudo su -
    cd /vagrant

    # remove
    chef-apply ./kafka-remove.rb
    chef-apply ./zookeeper-remove.rb

    # reinstall
    chef-apply ./zookeeper.rb
    chef-apply ./kafka.rb



# Package sources

All packages were installed from a simple private Yum repository:


    [el6-mvway]
    name=el6-mvway
    baseurl=http://download.mvway.com/repo/el6
    gpgcheck=0
    enabled=1


Zookeeper and Kafka main packages are:

    http://s3-sa-east-1.amazonaws.com/download.mvway.com/repo/el6/kafka-0.8.0-1.mv.x86_64.rpm
    http://s3-sa-east-1.amazonaws.com/download.mvway.com/repo/el6/zookeeper-3.4.5-1.el6.mv.x86_64.rpm

