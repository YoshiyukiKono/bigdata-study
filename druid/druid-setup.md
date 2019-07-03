# Single Server Quickstart

https://druid.apache.org/docs/latest/tutorials/index.html



# Tutorial: A First Look at Druid

http://druid.io/docs/0.8.2/tutorials/tutorial-a-first-look-at-druid.html

Druid part1 インストールとチュートリアル

https://www.youtube.com/watch?v=xO1LBLSwHds

バージョンが古い

# 実施記録

```
curl http://ftp.jaist.ac.jp/pub/apache/incubator/druid/0.15.0-incubating/apache-druid-0.15.0-incubating-bin.tar.gz -o apache-
tar -xzf apache-druid-0.15.0-incubating-bin.tar.gz
druid-0.15.0-incubating-bin.tar.gz
cd apache-druid-0.15.0-incubating
curl https://archive.apache.org/dist/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz -o zookeeper-3.4.11.tar.gz
tar -xzf zookeeper-3.4.11.tar.gz
mv zookeeper-3.4.11 zk

sudo yum install perl -y
sudo yum install java-1.8.0-openjdk -y

./bin/start-micro-quickstart
```
navigate to http://<host>:8888
  
## データ・ロード

1. Menu > Load Data
1. Local Disk
1. Base directory: quickstart/tutorial/
1. File Filter: wikiticker-2015-09-12-sampled.json.gz
1. Click "Preview"
1. "Next: Parse Data"
1. "Next: Parse Time"
1. "Next: Transform"
1. "Next: Filter"
1. "Next: Configure Schema"
1. turn off Rollup by clicking on the switch
1. "Next: Partition"
1. "Next: Tune"
1. Datasource name:wikipedia
1. "Next: Edit JSON spec"
1. "submit"
1. Menu > Datasources
1. Menu > Query
1. "select * from wikipedia"

