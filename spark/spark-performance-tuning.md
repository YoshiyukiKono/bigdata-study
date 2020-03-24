# Spark Performance Tuning

## Spark SQL
https://spark.apache.org/docs/latest/sql-performance-tuning.html

## Spark Performance Tuning-Learn to Tune Apache Spark Job
https://data-flair.training/blogs/apache-spark-performance-tuning/

2. What is Performance Tuning in Apache Spark?
The process of adjusting settings to record for memory, cores, and instances used by the system is termed tuning. This process guarantees that the Spark has optimal performance and prevents resource bottlenecking. Effective changes are made to each property and settings, to ensure the correct usage of resources based on system-specific setup. Apache Spark has in-memory computation nature. As a result resources in the cluster (CPU, memory etc.) may get bottlenecked.

Sometimes to decrease memory usage RDDs are stored in serialized form. Data serialization plays important role in good network performance and can also help in reducing memory usage, and memory tuning.
If used properly, tuning can:

- Ensure proper use of all resources in an effective manner.
- Eliminates those jobs that run long.
- Improves the performance time of the system.
- Guarantees that jobs are on correct execution engine.

3. Data Serialization in Spark

It is the process of converting the in-memory object to another format that can be used to store in a file or send over the network. It plays a distinctive role in the performance of any distributed application. The computation gets slower due to formats that are slow to serialize or consume a large number of files. Apache Spark gives two serialization libraries:

- Java serialization
- Kryo serialization

**Java serialization** – Objects are serialized in Spark using an ObjectOutputStream framework, and can run with any class that implements java.io.Serializable. The performance of serialization can be controlled by extending java.io.Externalizable. It is flexible but slow and leads to large serialized formats for many classes.

**Kryo serialization** – To serialize objects, Spark can use the Kryo library (Version 2). Although it is more compact than Java serialization, it does not support all Serializable types. For better performance, we need to register the classes in advance. We can switch to Karyo by initializing our job with SparkConf and calling-
conf.set(“spark.serializer”, “org.apache.spark.serializer.KyroSerializer”)

We use the registerKryoClasses method, to register our own class with Kryo. In case our objects are large we need to increase spark.kryoserializer.buffer config. The value should be large so that it can hold the largest object we want to serialize.
[Get the Best Spark Books to become Master of Apache Spark](https://data-flair.training/blogs/best-apache-spark-scala-books/).

4. Memory Tuning in Spark
Consider the following three things in tuning memory usage:

- Amount of memory used by objects (the entire dataset should fit in-memory)
- The cost of accessing those objects
- Overhead of garbage collection.

The Java objects can be accessed but consume 2-5x more space than the raw data inside their field. The reasons for such behavior are:

- Every distinct Java object has an “object header”. The size of this header is 16 bytes. Sometimes the object has little data in it, thus in such cases, it can be bigger than the data.
- There are about 40 bytes of overhead over the raw string data in Java String. It stores each character as two bytes because of String’s internal usage of UTF-16 encoding. If there are 10 characters String, it can easily consume 60 bytes.
- Common collection classes like HashMap and LinkedList make use of linked data structure, there we have “wrapper” object for every entry. This object has both header and pointer (8 bytes each) to the next object in the list.
- Collections of primitive types often store them as “boxed objects”. For example, java.lang.Integer.


4. Memory Tuning in Spark
Consider the following three things in tuning memory usage:

- Amount of memory used by objects (the entire dataset should fit in-memory)
- The cost of accessing those objects
- Overhead of garbage collection.

The Java objects can be accessed but consume 2-5x more space than the raw data inside their field. The reasons for such behavior are:

- Every distinct Java object has an “object header”. The size of this header is 16 bytes. Sometimes the object has little data in it, thus in such cases, it can be bigger than the data.
- There are about 40 bytes of overhead over the raw string data in Java String. It stores each character as two bytes because of String’s internal usage of UTF-16 encoding. If there are 10 characters String, it can easily consume 60 bytes.
- Common collection classes like HashMap and LinkedList make use of linked data structure, there we have “wrapper” object for every entry. This object has both header and pointer (8 bytes each) to the next object in the list.
- Collections of primitive types often store them as “boxed objects”. For example, java.lang.Integer.


