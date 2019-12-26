# HDFS Tips

## Replication Fix

```
sudo -u hdfs hdfs fsck / | grep 'Under replicated' | awk -F':' '{print $1}' >> /tmp/under_replicated_files
xargs -n 1000 sudo -u hdfs hdfs dfs -setrep 1 < /tmp/under_replicated_files
```

https://community.cloudera.com/t5/Community-Articles/Fix-Under-replicated-blocks-in-HDFS-manually/ta-p/244746
