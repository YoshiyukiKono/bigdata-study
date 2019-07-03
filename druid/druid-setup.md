# Single Server Quickstart

https://druid.apache.org/docs/latest/tutorials/index.html



# Tutorial: A First Look at Druid

http://druid.io/docs/0.8.2/tutorials/tutorial-a-first-look-at-druid.html

Druid part1 インストールとチュートリアル

https://www.youtube.com/watch?v=xO1LBLSwHds

バージョンが古い

# 実施記録

```
curl http://ftp.jaist.ac.jp/pub/apache/incubator/druid/0.15.0-incubating/apache-druid-0.15.0-incubating-bin.tar.gz -o apache-druid-0.15.0-incubating-bin.tar.gz
cd apache-druid-0.15.0-incubating
curl https://archive.apache.org/dist/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz -o zookeeper-3.4.11.tar.gz
tar -xzf zookeeper-3.4.11.tar.gz
mv zookeeper-3.4.11 zk
./bin/start-micro-quickstart
```
navigate to http://localhost:8888
