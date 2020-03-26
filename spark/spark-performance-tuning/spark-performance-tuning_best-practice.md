
https://blog.cloudera.com/how-to-tune-your-apache-spark-jobs-part-2/

コマンド・ライン・フラグまたは構成プロパティは、要求されたエグゼキュータの数を制御します。
CDH 5.4 / Spark 1.3以降では、プロパティでダイナミックアロケーションをオンにすることで、このプロパティの設定を回避できます。
動的割り当てにより、Sparkアプリケーションは、保留中のタスクのバックログがある場合にエグゼキューターをリクエストし、
アイドル状態になるとエグゼキューターを解放できます。
--num-executorsspark.executor.instancesspark.dynamicAllocation.enabled

![spark-tuning2-f1.png](https://ndu0e1pobsf1dobtvj5nls3q-wpengine.netdna-ssl.com/wp-content/uploads/2019/08/spark-tuning2-f1.png)

Executer Container は、yarn.nodemanager.resource.memory-mbの内部にある（yarnのメモリ設定を超えるメモリは使えない？）

多くのメモリを使用してエグゼキュータを実行すると、ガベージコレクションが過度に遅延することがよくあります。
*64GB*は、1つのエグゼキュータの適切な上限での概算です。

HDFSクライアントが大量の同時スレッドで問題を抱えていることに気づきました。
大まかな推測では、エグゼキューターあたり*最大5つのタスクで完全な書き込みスループットを達成*できるため、
エグゼキューターあたりのコア数をその数より少なくすることをお勧めします。

小さなエグゼキュータを実行すると（たとえば、単一のコアと、単一のタスクを実行するのに十分なメモリが必要）、単一のJVMで複数のタスクを実行することから得られる利点がなくなります。
たとえば、ブロードキャスト変数は各エグゼキューターで1回複製する必要があるため、小さなエグゼキューターが多いと、データのコピーが多くなります。

```
org.apache.spark.serializer.KryoSerializer
```
(具体的な設定は？)



http://spark.apache.org/docs/1.2.0/tuning.html#memory-tuning

ディスクへのデータの格納方法を決定する権限がある場合は常に、Avro、Parquet、Thrift、Protobufなどの拡張可能なバイナリ形式を使用してください。





