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
