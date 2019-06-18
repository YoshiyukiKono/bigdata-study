
https://www.slideshare.net/dragan10/pyspark20170630-sapporo-db-analytics-showcase とか https://www.slideshare.net/wesm/improving-python-and-spark-pyspark-performance-and-interoperability
slideshare.net

PySparkの勘所（20170630 sapporo db analytics showcase）
2017年6月30日にインサイトテクノロジーさま主催のdb analytics showcaseでしゃべったPySparkの話のスライドです。
slideshare.net
Improving Python and Spark (PySpark) Performance and Interoperability
Slides from Spark Summit East 2017 — February 9, 2017 in Boston. Discusses ongoing development work to accelerate Python-on-Spark performance using Apache Arro…

WorkerとDriver環境とでPythonのバージョン不一致しても良い（あるいはPython環境は不要）とも考えられるのでは？（でも不一致でエラーになった記憶がある）という疑問は、
UDFをPythonコードで実装した場合にはWorkerのPythonプロセスが使われる、という（今回初めて認識した）点をよくよく考えたら、
UDF使うときだけ、器用にバインディングするということもなさそうなので、実行時に、バージョンの整合性（あるいはPython環境の存在確認）が行われる、
としても自然な気がしてきました。

きっと全ての答えはここにあります -> https://github.com/apache/spark

あと、昨日日本語版が出てましたが、C# 対応の話。 https://www.infoq.com/jp/news/2019/06/microsoft-net-apache-spark/
