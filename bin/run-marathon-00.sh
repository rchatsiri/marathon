#!/bin/bash
sudo nohup ./start --master zk://192.168.1.177:2181/mesos --zk zk://192.168.1.177:2181/marathon --http_port=7070 > /opt/sdn/log/marathon/marathon-00.log &

