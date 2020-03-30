https://community.cloudera.com/t5/Support-Questions/How-to-determine-the-number-of-requests-connections-going-to/td-p/280779

HMSからHiveメタストアデータベースへのリクエスト/接続の数を確認するにはどうすればよいですか？


Hiveプロパティhive.metastore.server.max.threadsとhive.metastore.server.min.threadsがあることは知っています 。
しかし、HMSのアクティブスレッドを見つける方法。そして、よりアクティブなスレッドを引き起こしているもの（ジョブまたはユーザー）は？ 

あなたの主題とあなたの実際の質問は大きく異なり、両方とも完全に異なるものです。

Hive MetastoreプロセスからMetastoreデータベースへの接続数が心配な場合は、以下の方法を使用できます。

 

1.以下のコマンドを使用して、サーバー上のHMSプロセスのPIDを確認します。
```
ps -ef | grep -i hivemetastore
```
 

2. PIDを取得したら、以下のコマンドのputを取得します。
```
lsof -p PID | grep ESTABLISHED
```
これにより、Hivemetastoreプロセスとの間で行われているすべての接続のリストが表示されます。これには、クライアントから、つまりHive CLIシェルから「TO」Hivemetastoreプロセスで行われた接続も含まれます。

出力でデータベースタイプを探し、HivemetastoreからHMS DBへの接続を確認してください。

たとえば、私の側では、以下の出力があります：

!()[https://xgkfq28377.i.lithium.com/t5/image/serverpage/image-id/25052iECC056ABEB2F425E/image-size/large?v=1.0&px=999]

上の写真では、「mysql」を含むすべての出力がHiveMetastoreプロセスからHMS DBに作成されています。

 

説明の質問に従って、データベースに接続しようとしているスレッドの数をいつでも知りたい場合は、HMSプロセスのjstackを収集して、mysql呼び出しを参照しているスレッドを探します（これは私の場合はデータベースの種類です。データベースの種類がOracleまたはPostgresの場合は、それらを検索できます）。

 

また、データベースへの接続数が気になるようです。

Hive CLIとbeelineを介して以下のプロパティを確認できます（このプロパティは、組み込まれているため、Ambariにはリストされません）。

 
```
set datanucleus.connectionPool.maxPoolSize;
```
-これにより、接続プールのサイズが決まります。10がデフォルト値です。他の値に設定されている場合は、お知らせください。

また、以下のクエリの出力を共有します
```
set datanucleus.connectionPoolingType;
```
 

使用している正確なHDPバージョンを確認してください!!!

 

接続プールが10に設定されていても、HMS DBへの接続が10個しかないことを意味するわけではありません。接続数が増える可能性がありますが、この値を増やすと、HMS DBへの接続数も指数関数的に増加します。

 

場合によっては、Hiveでの大量のクエリに対応するために、接続プールのサイズを増やすことが推奨されます。

したがって、Hiveサービスを広範囲に使用していて、connectionpoolsizeの値を高く設定している場合は、HMS DB側で問題を修正して、より多くの接続を許可することをお勧めします。

たとえば、MySQLにはmax_connectionsがあり、1000以上に増やすことができます。
