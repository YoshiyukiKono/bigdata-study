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

もし、ORCフォーマットのHiveテーブルを読み書きする際は設定しましょう。

spark.sql.orc.enabled
spark.sql.hive.convertMetastoreOrc
spark.sql.orc.filterPushdown
spark.sql.orc.char.enabled

## その他
デフォルトだと試行回数が2回なので1回にします。
spark.yarn.maxAppAttempts
