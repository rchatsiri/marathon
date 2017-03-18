#!/bin/bash
sudo nohup ./start --master zk://202.129.206.30:2181/mesos --zk zk://202.129.206.30:2181/marathon --http_port=7070 > /opt/sdn/log/marathon/marathon-00.log &

