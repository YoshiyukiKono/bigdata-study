https://mapr.com/support/s/article/Spark-Troubleshooting-guide-Tuning-Spark-Estimating-Memory-and-CPU-utilization-for-Spark-jobs?language=ja

https://mapr.com/support/s/article/Spark-Troubleshooting-guide-Tuning-Spark-Estimating-Memory-and-CPU-utilization-for-Spark-jobs?

# Spark トラブルシューティングガイド: Spark チューニング: Spark ジョブに利用されるメモリと CPU の見積もり
各 Spark ジョブに利用されるメモリと CPU を解析的に計算することは、単純なプロセスではありません。しかし、トラブルシューティングのためにリソースの見積もりが必要な場合、以下の方法が利用できます。


各 Spark ジョブに利用されるメモリと CPU を解析的に計算することは、単純なプロセスではありません。
しかし、トラブルシューティングのためにリソースの見積もりが必要な場合、以下の方法が利用できます。

EnvironmentE.g.: MapR 4.1 Hbase 0.98 Redhat 5.5 Note: It’s also good to indicate details like: MapR 4.1 (reported) and MapR 4.0 (unreported but likely)
Spark 2.0
Solution<Ensure you call out if authorized access / privileges are needed by customers> Following are the steps taken to resolve the issue: 1. <Step 1> – <flags that indicate that Step 1 was a success> 2. <Step 2> – <flags that indicate Step 2 success>

以下の例では、ジョブのリソースを見積もる際の core と executor の関係を表しています。

80 core と 320 GB メモリを持つ 5 ノードクラスタを例にします。

１ノードあたり 16 コアと 64 GB メモリを持っていることになります。

以下のように計算して見積もりを行います。

1) 各ノードで 2 core と 8GB メモリを OS とその他のプロセス用のリソースに確保します。(この時点で、74 core と 280GB メモリを Spark で利用できます。)
 
2) Executor あたり、およそ 3 - 5 スレッドが MFS へのアクセスに利用されます。今回は 3 スレッドとし、3 core を executor に割り当てます。
```
--executor-cores = 3
```
3) ノードあたり 14 core が利用可能ですが、Application Master 用として 1 core を確保し、残りを executor あたりの core 数で分割します。 ノードあたりの executor 数は (14 - 1) / 3 = 4 となります。

5 ノードクラスタのため executor 数は以下となります。
```
--num-executors = 20
```
この場合、 3 core * 4 executor = 12 スレッドが各ノードの MFS にアクセスすることになります。 
 
4) ノードあたり 56 GB のメモリが利用可能ですが、4 executor が動作するため、executor あたりのメモリは 14 GB となります。
YARN のオーバヘッド用に 10% を確保し、12GB を割り当てます。
```
--executor-memory = 12
```
これによって、 20*3 = 60 core、 12 * 20 = 240 GB メモリが利用され、ノード上の他のプロセスのためのリソースが十分に確保されます。 
 
Executor あたり 4 core、 ノードあたり 3 executor とすることも可能です。この場合、executor あたりのメモリは 19GB となります。

