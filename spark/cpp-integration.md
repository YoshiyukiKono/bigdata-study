

C/C++拡張されたPythonライブラリをCloudera Data Science WorkbenchとSparkクラスタで分散実行する

https://blog.cloudera.co.jp/conda-recipe-to-use-c-extended-python-library-on-pyspark-cluster-with-cloudera-data-science-workbench-224ab84570da

ここでは、swig（下記のSlideshareで言及あり）が使われている。

分散処理実行のサンプル

https://github.com/chezou/mecab-on-pyspark/blob/master/mecab-test.py

上記で言及されている「前の記事」：Sparkクラスタ上で好きなPythonライブラリをCloudera Data Science Workbenchから使う

https://blog.cloudera.co.jp/use-your-favorite-python-library-on-pyspark-33097ac868fb

Anacondaの仮想環境を作りZipで配布することで、他部門に依頼することなく、Cloudera Data Science Workbenchを使い好きなPythonのライブラリをPySparkクラスタで実行することができました。これにより、データサイエンティストはクラスタの設定を変えることなく、好きなライブラリを使うことができます。



Integrating Existing C++ Libraries into PySpark with Esther Kundin

https://www.slideshare.net/databricks/integrating-existing-c-libraries-into-pyspark-with-esther-kundin

Python to CPP Conversion

https://github.com/pybee/seasnake
