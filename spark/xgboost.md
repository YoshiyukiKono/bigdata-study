### maropu/xgboost-on-spark

https://gist.github.com/maropu/33794b293ee937e99b8fb0788843fa3f

### 

https://github.com/myui/hivemall/blob/master/spark/spark-2.0/src/test/scala/org/apache/spark/sql/hive/XGBoostSuite.scala

上記は、ApacheのIncubatorに移っていた。

## Hivemall

http://hivemall.incubator.apache.org/

### Apache Hivemall Overview
Apache Hivemall is a scalable machine learning library that runs on Apache Hive/Pig/Spark. Apache Hivemall is designed to be scalable to the number of training instances as well as the number of training features.

### Supported Algorithms
Apache Hivemall provides machine learning functionality as well as feature engineering functions through UDFs/UDAFs/UDTFs of Hive.

#### Binary Classification
Perceptron

Passive Aggressive (PA, PA1, PA2)

Confidence Weighted (CW)

Adaptive Regularization of Weight Vectors (AROW)

Soft Confidence Weighted (SCW1, SCW2)

AdaGradRDA (w/ hinge loss)

Factorization Machine (w/ logistic loss)

My recommendation is AROW, SCW1, AdaGradRDA, and Factorization Machine while it depends.

#### Multi-class Classification
Perceptron

Passive Aggressive (PA, PA1, PA2)

Confidence Weighted (CW)

Adaptive Regularization of Weight Vectors (AROW)

Soft Confidence Weighted (SCW1, SCW2)

Random Forest Classifier

Gradient Tree Boosting (Experimental)

My recommendation is AROW and SCW while it depends.

#### Regression
Logistic Regression using Stochastic Gradient Descent

AdaGrad, AdaDelta (w/ logistic Loss)

Passive Aggressive Regression (PA1, PA2)

AROW regression

Random Forest Regressor

Factorization Machine (w/ squared loss)

Polynomial Regression

My recommendation for is AROW regression, AdaDelta, and Factorization Machine while it depends.

#### Recommendation
Minhash (LSH with jaccard index)

Matrix Factorization (sgd, adagrad)

Factorization Machine (squared loss for rating prediction)

#### k-Nearest Neighbor
Minhash (LSH with jaccard index)

b-Bit minhash

Brute-force search using Cosine similarity

#### Anomaly Detection
Local Outlier Factor (LOF)
#### Natural Language Processing
English/Japanese Text Tokenizer
#### Feature engineering
Feature Hashing (MurmurHash, SHA1)

Feature scaling (Min-Max Normalization, Z-Score)

Polynomial Features

Feature instances amplifier that reduces iterations on training

TF-IDF vectorizer

Bias clause

Data generator for one-vs-the-rest classifiers

#### System requirements
Hive 0.13 or later

Java 7 or later

Spark 1.6 or 2.0 for Apache Hivemall on Spark

Pig 0.15 or later for Apache Hivemall on Pig

More detail in documentation.
