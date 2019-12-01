# Spark

Spark - RDDs & DataFrames: 

34. How to launch & exit spark shell? 

Scala:  To Start: spark-shell  During this process, observe the log. It displays Spark, Scala & Hive versions available in the cluster  To Exit:  exit  

35. What is an RDD & how to create an RDD? 

RDD:  Fundamental is the way of representing data sets distributed across multiple nodes.  They are Immutable (unchanged over time) and fault tolerant.  

3 Ways to create an RDD:  

Parallelizing existing collection:  
```
val data = Array(1, 2, 3, 4, 5) 
val rddData = sc.parallelize(data) 
```
From External Data sets:  
```
import org.apache.spark.sql.SparkSession  

val spark = SparkSession.builder.appName("AvgAnsTime").master("local").getOrCreate() 
val rddTxtFile = spark.read.textFile("data.txt").rdd 
val rddCSVFile = spark.read.csv("data.csv").rdd 
val rddJSONFile = spark.read.json("data.json").rdd 
```
From Existing RDD through Transformation (Count, Filter, Map, Distinct etc.):  
```
import org.apache.spark.sql.SparkSession  
val words = spark.sparkContext.parallelize(Seq("the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog")) 
val wordPair = words.map(w => (w.charAt(0), w)) 
wordPair.foreach(println) 
```
36. Detailed explanation of all elements of “Programming with Spark”, with wordcount & word count variants. 
```
val textFile = sc.textFile("hdfs://...") 
val counts = textFile.flatMap(line => line.split(" ")) .map(word => (word, 1)) .reduceByKey(_ + _) counts.saveAsTextFile("hdfs://...") 
```
37. How to join two RDDs? 

Example to print ----- 
```
val manager = sc.textFile("spark1/EmployeeManager.csv") 
val managerPairRDD = manager.map(x=> (x.split(",")(0),x.split(",")(1))) 
val name = sc.textFile("spark1/EmployeeName.csv") 
val namePairRDD = name.map(x=> (x.split(",")(O),x.split(",")(1))) 
val salary = sc.textFile("spark1/EmployeeSalary.csv") 
val salaryPairRDD = salary.map(x=> (x.split(",")(O),x.split(",")(1))) 
val joined = namePairRDD.join(salaryPairRDD).join(managerPairRDD)                                                         
joined.collect() 
```
38. How to apply filter & remove headers? 
```
val managerRemovedHeader = managerPairRDD.filter(_(O)!= header(O)) 
val managerPairRDDFiltered = managerRemovedHeader.filter(x => x("id") "Raj") 
```
39. How to apply filters on data using Broadcast variables? 

```
val content = sc.textFile("spark2/Content.txt") //Load the text file 
val words = content.flatMap(line => line.split(" " )) 
val remove = sc.textFile("spark2/Remove.txt") //Load the text file 
val removeRDD= remove.flatMap(x=> x.split(",")).map(word=>word.trim) //Create an array of words 
val bRemove = sc.broadcast(removeRDD.collect().toList) 
val filtered = words.filter { case (word) => !bRemove.value.contains(word) } 
filtered.collect()
```

40. How to save data to single file/multiple files & give specific naming pattern

filtered.foreach{ case(k, rdd) => rdd.saveAsTextFile("spark5/Employee"+k) }

41. How to save result in various file formats & specific delimiters?

filtered.map { x => x.productIterator.mkString("\t") }.saveAsText("path-to-store")

42. How to filter data using regular expression & save different data, differently?

43. How to save the data of an RDD by using specific compresssion technique

import org.apache.hadoop.io.compress.GzipCodec
dataRDD.saveAsTextFile("", classOf[GZipCodec])

44. How to sort the data before saving it to HDFS

val joinedData = joined.sortByKey()
joinedData.collect()

45. How to do groupBy & Aggregation of data?

46. What is a DataFrame & how to create a DataFrame?

47. How to register a DataFrame as a table?

auctionsDF.registerTempTable("auctionsDF")

48. How to apply various operations on a DataFrame?

49. How to apply aggregation on a particular column?

50. How to compute statistics on a specific column?

xboxes.describe("price").show

51. How to name the columns of a file?

52. What are pairRDDs and how to create them?

53. How to apply various operations on pairRDDs?

Aggregations: reduceByKey(), foldByKey(), combineByKey(), countByKey()

54. What are the types of joins? How to join the pairRDDs?

55. What is a partitioner & apply various functions to deal with partitioner?

56. How to create functions & use them in Spark?

case class Person(id: Int) defined class Person

...

57. How to apply loops on DataFrame?
``
for i, s in df.iterrows():
  print(s)
``


