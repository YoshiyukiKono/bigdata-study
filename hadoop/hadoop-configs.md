CDSWの環境

```
$ set | grep HADOOP
HADOOP_COMMON_HOME=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop
HADOOP_CONF_DIR=/etc/spark/conf/yarn-conf:/etc/hive/conf
HADOOP_HOME=/opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/hadoop
HADOOP_USER_NAME=user1
```

HADOOP_CONF_DIRに`/etc/hadoop/conf`が存在しない。そのため、`hdfs`コマンドの実行に失敗する。
HADOOP_CONF_DIRをクリアすることにより、デフォルトの設定ファイル格納フォルダを使うため、`hdfs`コマンドが実行できるようになる。
（このとき`hive`コマンドは実行できなくなる）
HADOOP_CONF_DIRに`/etc/hadoop/conf`を追加するのが適当。

上記の状態がなぜ生じたのかを確認しようとしたが、どこで環境変数の設定が行われているか分からなかった。

```
cdsw@sriugoe0bxam3kf2:~$ ls -la !$
ls -la /etc/skel/
total 24
drwxr-xr-x.  2 root root   57 Jun 10  2019 .
drwxrwxrwx. 87 root root 8192 Jan 24 02:14 ..
-rw-r--r--.  1 root root  220 Aug 31  2015 .bash_logout
-rw-r--r--.  1 root root 3771 Aug 31  2015 .bashrc
-rw-r--r--.  1 root root  655 May  9  2019 .profile
cdsw@sriugoe0bxam3kf2:~$ grep HADOOP /etc/skel/.*
grep: /etc/skel/.: Is a directory
grep: /etc/skel/..: Is a directory
cdsw@sriugoe0bxam3kf2:~$ grep HADOOP /etc/profile
cdsw@sriugoe0bxam3kf2:~$ grep HADOOP /etc/b
bash.bashrc             bash_completion.d/      binfmt.d/
bash_completion         bindresvport.blacklist  
cdsw@sriugoe0bxam3kf2:~$ grep HADOOP /etc/bash*
grep: /etc/bash_completion.d: Is a directory
```

Dockerイメージ内での環境変数設定について理解する必要がある。
