https://qiita.com/seikei1874/items/9bc327362f59777562aa

## Dynamic Allocation
無駄なリソースを使わないことに越したことはないので、動的リソース確保ができるようにします。
DynamicAllocationを有効にするには、ShuffleServiceも有効にする必要があります。
使われないExecutorが削除されるので、Shuffleのファイルを別な場所に退避させておくためです。

spark.dynamicAllocation.enabled
spark.shuffle.service.enabled

頻繁にExecutorを作成、削除するのも無駄なので削除される時間を調整しましょう。

spark.dynamicAllocation.executorIdleTimeout

Memory Magement
データがメモリから溢れたら元も子もないのでサイズ調整しましょう。
spark.memory.offHeap.enabled
spark.memory.offHeap.size
spark.executor.memory
spark.yarn.executor.memoryOverhead

## Shuffle
OOMとかFetchエラーが出る場合は分割サイズが大きいのかも、もっと分割しましょう。

spark.default.parallelism
spark.sql.shuffle.partitions

### Apache Spark Document
http://mogile.web.fc2.com/spark/spark200/tuning.html
デフォルトを変更するために設定プロパティspark.default.parallelism を設定してください。一般的に、クラスタ内のCPUコアあたり2-3のタスクがお勧めです。


メモリよりディスクが遅いのは自明なのでキャッシュサイズを調整しましょう。

spark.shuffle.file.buffer
spark.unsafe.sorter.spill.reader.buffer.size
spark.shuffle.unsafe.file.output.buffer
spark.shuffle.service.index.cache.entries

圧縮ブロックサイズも調整して、無駄は無くしましょう。

spark.io.compression.lz4.blockSize

ShuffleServer自体の性能も調整しましょう。

spark.shuffle.io.serverThreads
spark.shuffle.io.backLog
spark.shuffle.registration.timeout
spark.shuffle.registration.maxAttempts

## タスク再実行
１つのタスクが遅いために全体が引きずられて遅くなることがあります。
再起動を判断する投機的実行と再実行する閾値を定義します。

spark.speculation
spark.speculation.multiplier

spark.max.fetch.failures.per.stage

## TimeOut
デフォルトでTimeOutエラーがでるようなら調整しましょう。

spark.sql.broadcastTimeout
spark.network.timeout

## シリアライズ／フォーマット変換
```
spark.serializer=org.apache.spark.serializer.KryoSerializer
```
> Finally, if you don’t register your custom classes, Kryo will still work, but it will have to store the full class name with each object, which is wasteful.

もし、ORCフォーマットのHiveテーブルを読み書きする際は設定しましょう。

spark.sql.orc.enabled
spark.sql.hive.convertMetastoreOrc
spark.sql.orc.filterPushdown
spark.sql.orc.char.enabled

## その他
デフォルトだと試行回数が2回なので1回にします。
spark.yarn.maxAppAttempts

## 設定例
http://mogile.web.fc2.com/spark/spark200/configuration.html#environment-variables

```
./bin/spark-submit --name "My app" --master local[4] --conf spark.eventLog.enabled=false
  --conf "spark.executor.extraJavaOptions=-XX:+PrintGCDetails -XX:+PrintGCTimeStamps" myApp.jar
```

```
spark.master            spark://5.6.7.8:7077
spark.executor.memory   4g
spark.eventLog.enabled  true
spark.serializer        org.apache.spark.serializer.KryoSerializer
```


