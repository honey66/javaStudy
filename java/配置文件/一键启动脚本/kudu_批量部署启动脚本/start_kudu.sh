#!/bin/sh
for host in node1 node2 node3 
do
  ssh $host "service kudu-master start;service kudu-tserver start"
  echo "$host is running"
done
