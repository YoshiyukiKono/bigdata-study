# CDSW Python 2 / 2Core/ 16GB
 
# git clone https://github.com/databricks/spark-deep-learning
# cd spark-deep-learning
# build/sbt assembly
 
# !pip install --upgrade keras
# !pip install --upgrade tensorflow
# !pip install numpy --upgrade
# !pip install image
 
# Read https://medium.com/linagora-engineering/making-image-classification-simple-with-spark-deep-learning-f654a8b876b8
# wget https://github.com/zsellami/images_classification/raw/master/personalities.zip
# unzip to HDFS
 
# Configure the Spark Requirements
import cdsw
import tensorflow as tf
 
from pyspark.conf import SparkConf
from pyspark.context import SparkContext
from pyspark.sql.functions import lit
 
# Establish the Spark Session
conf = SparkConf().set("spark.jars", "/home/cdsw/spark-deep-learning/target/scala-2.11/spark-deep-learning-assembly-1.5.1-SNAPSHOT-spark2.4.jar")
sc = SparkContext( conf=conf)
 
# Add in the sparkdl Dependancies
sys.path.insert(0, "/home/cdsw/spark-deep-learning/target/scala-2.11/spark-deep-learning-assembly-1.5.1-SNAPSHOT-spark2.4.jar")
 
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml import Pipeline
