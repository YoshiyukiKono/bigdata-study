# Superset Docker トライアル

下記を参考にDockerで環境を作成する。

http://superset.incubator.apache.org/installation.html

```
git clone https://github.com/apache/incubator-superset/
cd incubator-superset/contrib/docker
# prefix with SUPERSET_LOAD_EXAMPLES=yes to load examples:
docker-compose run --rm superset ./docker-init.sh
# you can run this command everytime you need to start superset now:
docker-compose up
# After several minutes for superset initialization to finish, you can open a browser and view http://localhost:8088 to start your journey.
```

## Gitインストール

```
sudo yum install git
sudo yum update -y nss curl libcurl
```

## Dockerインストール・環境設定

```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum -y install docker-ce
docker --version
```

```
sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

### Dockerユーザ設定

Dockerコマンドをsudoなしで実行する方法

https://qiita.com/DQNEO/items/da5df074c48b012152ee

```
# dockerグループがなければ作る
sudo groupadd docker

# 現行ユーザをdockerグループに所属させる
sudo gpasswd -a $USER docker

# dockerデーモンを再起動する (CentOS7の場合)
sudo systemctl restart docker

# exitして再ログインすると反映される。
exit
```

このステップを踏まないと、下記のような（一見関連性の不明な※）エラーが表示される
```
ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running?

If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.
```
※　下記URLの記載では、
「Docker version 1.12. などだと tcp ではなく unix domain socket でやっているため、
上記 docker-compose コマンドを実行したユーザにそれにアクセスできる権限を付与する必要がある。」とのこと。

https://qiita.com/rysk92/items/e10f898abdc701e09e38

* 上記のエラーに対応しようとして、`docker-machine start default`を試し、`default`が存在しない、というエラーが表示された。
* そこで、`docker-machine create --driver virtualbox default`など、試したが、結局上記のユーザ設定が功を奏した。

### Docker Update

```
curl -L https://github.com/docker/compose/releases/download/1.18.0-rc2/docker-compose-`uname -s-uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```
### 参考資料

Get started with Docker Machine and a local VM

https://docs.docker.com/machine/get-started/


## Superset Docker環境実行

```
SUPERSET_LOAD_EXAMPLES=yes docker-compose run --rm superset ./docker-init.sh
```

```
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                    PORTS                    NAMES
be813323312c        docker_superset     "/entrypoint.sh"         24 minutes ago      Up 24 minutes (healthy)   0.0.0.0:8088->8088/tcp   docker_superset_1
f24b3bb9a552        postgres:10         "docker-entrypoint.s…"   38 minutes ago      Up 38 minutes             0.0.0.0:5432->5432/tcp   docker_postgres_1
d56c3f0c131f        redis:3.2           "docker-entrypoint.s…"   39 minutes ago      Up 39 minutes             0.0.0.0:6379->6379/tcp   docker_redis_1
```
