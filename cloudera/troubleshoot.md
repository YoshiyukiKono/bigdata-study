# Troubleshoot

## Re: Yarn Service : Error on start CDH5
  
```
Created ‎11-21-2015 12:08 PM
**ERROR- Details Updated** Permission denied: user=mapred, access=WRITE, inode="/":hdfs:supergroup:drwxr-xr-x
```

https://community.cloudera.com/t5/Support-Questions/Yarn-Service-Error-while-starting-CDH5/td-p/34304
```
sudo -u hdfs hadoop fs -chmod -R 777 /
```

## The Hive Metastore canary failed to create a database

https://community.cloudera.com/t5/Support-Questions/The-Hive-Metastore-canary-failed-to-create-a-database/td-p/81021
```
[centos@ip-10-0-0-61 ~]$ sudo -u hdfs hdfs dfs -ls /
Found 2 items
drwx-wx-wx   - hive   supergroup          0 2020-02-25 11:52 /tmp
drwxrwx---   - mapred supergroup          0 2020-02-25 11:52 /user
[centos@ip-10-0-0-61 ~]$ sudo -u hdfs hdfs dfs -chmod +x /user
[centos@ip-10-0-0-61 ~]$ sudo -u hdfs hdfs dfs -ls /
Found 2 items
drwx-wx-wx   - hive   supergroup          0 2020-02-25 11:52 /tmp
drwxrwx--x   - mapred supergroup          0 2020-02-25 11:52 /user
```
