# Docker Install - CentOS

yumのインストールは最新ではなく、マルチ・ステージビルドのサポートがない

https://qiita.com/3utama/items/8177dfca37e80ce6a8cd

https://qiita.com/okcoder/items/e91f1e339c114e0be129

上記にしたがって、yumのリポジトリーを追加後、最新版をインストールする。

```
sudo yum remove docker  docker-client  docker-client-latest  docker-common  docker-latest  docker-latest-logrotate  docker-logrotate  docker-selinux  docker-engine-selinux  docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl enable docker
docker -v
sudo service docker start
sudo service docker status
sudo docker run hello-world
```


```
sudo docker build --build-arg HBASE_VERSION="2.0.5" -t kirasoa/apache-hbase-pseudo:2.0.5 -f Dockerfile.pseudo .

```
