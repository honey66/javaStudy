#!/bin/sh
for host in node1 node2 node3 
do
  ssh $host "service kudu-master stop;service kudu-tserver stop"
  echo "$host is running"
done
