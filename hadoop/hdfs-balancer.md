
IHAC who lived with this for an year having mixed hardware - set of nodes with 12*1.2TB nodes and set of nodes with 14*6TB which is much worse than what you have here. 

There will be hotspot issues no doubt. To avoid that, customer will have to run HDFS balancer with less capacity nodes as source to balance only from low capacity nodes. They can plan to run these during less busy times on the cluster and over weekends until they fully replace all nodes with 2TB disks.

```
#!/bin/sh
export KRB5_CONFIG=/usr/java/default/jre/lib/security/krb5.conf
CLUSTER=`cat /usr/java/default/jre/lib/security/krb5.conf | grep default_realm | awk '{print $3}'`

kinit -kt /etc/security/keytabs/hdfs.headless.keytab hdfs@${CLUSTER}

hdfs dfsadmin -setBalancerBandwidth 309715200

for i in {1..10}
do
  echo "Manual HDFS Balancer - Iteration# $i"

hdfs balancer -Ddfs.datanode.balance.max.concurrent.moves=14 -source -f /u/users/hdfs/boxes.prod7.g7  -threshold 35

   if [ $? -ne 0 ]
   then
  	kinit -kt /etc/security/keytabs/hdfs.headless.keytab hdfs@${CLUSTER}
   fi
done
```
