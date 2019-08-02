/*
git clone --recursive https://github.com/dmlc/xgboost
cd xgboost
mkdir build
cd build
cmake ..
make -j4

wget http://mirrors.ocf.berkeley.edu/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
tar xzvf apache-maven-3.6.1-bin.tar.gz 
export PATH=$PATH:/home/cdsw/apache-maven-3.6.1/bin

cd /home/cdsw/xgboost/jvm-packages
mvn package

wget https://raw.githubusercontent.com/uiuc-cse/data-fa14/gh-pages/data/iris.csv
hdfs dfs -put iris.csv /tmp/.
*/

// https://xgboost.readthedocs.io/en/latest/jvm/xgboost4j_spark_tutorial.html

%AddJar file:/home/cdsw/xgboost/jvm-packages/xgboost4j-spark/target/xgboost4j-spark_2.12-1.0.0-SNAPSHOT.jar

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types.{DoubleType, StringType, StructField, StructType}

val spark = SparkSession.builder().getOrCreate()
val schema = new StructType(Array(
  StructField("sepal length", DoubleType, true),
  StructField("sepal width", DoubleType, true),
  StructField("petal length", DoubleType, true),
  StructField("petal width", DoubleType, true),
  StructField("class", StringType, true)))

val rawInput = spark.read.schema(schema).csv("/tmp/iris.csv")

import org.apache.spark.ml.feature.StringIndexer
val stringIndexer = new StringIndexer().
  setInputCol("class").
  setOutputCol("classIndex").
  fit(rawInput)
val labelTransformed = stringIndexer.transform(rawInput).drop("class")

import org.apache.spark.ml.feature.VectorAssembler
val vectorAssembler = new VectorAssembler().
  setInputCols(Array("sepal length", "sepal width", "petal length", "petal width")).
  setOutputCol("features")
val xgbInput = vectorAssembler.transform(labelTransformed).select("features", "classIndex")

import ml.dmlc.xgboost4j.scala.spark.XGBoostClassifier
val xgbParam = Map("eta" -> 0.1f,
      "missing" -> -999,
      "objective" -> "multi:softprob",
      "num_class" -> 3,
      "num_round" -> 100,
      "num_workers" -> 2)
val xgbClassifier = new XGBoostClassifier(xgbParam).
      setFeaturesCol("features").
      setLabelCol("classIndex")
///

val xgbClassifier = new XGBoostClassifier().
  setFeaturesCol("features").
  setLabelCol("classIndex")
xgbClassifier.setMaxDepth(2)

val xgbClassificationModel = xgbClassifier.fit(xgbInput)

val results = xgbClassificationModel.transform(testSet)


/////////////////////////////////
import ml.dmlc.xgboost4j.scala.spark.XGBoostClassifier
import org.apache.spark.ml.{Pipeline, PipelineModel}
import org.apache.spark.ml.feature.{VectorAssembler, StringIndexer, IndexToString}

val df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/tmp/iris.csv")
df.printSchema()
val Array(training, test) = df.randomSplit(Array(0.8, 0.2),123)


val assembler = new VectorAssembler().setInputCols(Array("sepal_length","sepal_width","petal_length","petal_width")).setOutputCol("features")
val labelIndexer = new StringIndexer().setInputCol("species").setOutputCol("label")
//val indexed = labelIndexer.fit(df).transform(df)

//import ml.dmlc.xgboost4j.scala.spark.XGBoostEstimator
//val boost = new XGBoostEstimator(Map[String, Any]("num_round"->20, "nworkers"->3,"objective"->"multi:softprob","num_class"->3,"eta"->0.3,"max_depth"->3))
