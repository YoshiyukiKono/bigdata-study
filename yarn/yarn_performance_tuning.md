## Youtube

Dynamic Resource Pool Configuration

https://www.youtube.com/watch?v=8C_haXro7Hs

Cloudera YARN Tuning

https://www.youtube.com/watch?v=O2pH6NeAquk

## Cloudera Documentation

https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cdh_ig_yarn_tuning.html

## Cloudera Blog

### Untangling Apache Hadoop YARN
- http://blog.cloudera.com/blog/2015/09/untangling-apache-hadoop-yarn-part-1/
- http://blog.cloudera.com/blog/2015/10/untangling-apache-hadoop-yarn-part-2/
- http://blog.cloudera.com/blog/2016/01/untangling-apache-hadoop-yarn-part-3/
- http://blog.cloudera.com/blog/2016/06/untangling-apache-hadoop-yarn-part-4-fair-scheduler
-queue-basics/
- http://blog.cloudera.com/blog/2017/02/untangling-apache-hadoop-yarn-part-5-using-fairsche
duler-queue-properties/
- http://blog.cloudera.com/blog/2018/06/yarn-fairscheduler-preemption-deep-dive/

## Cloudera Community

FairScheduler Tuning With assignmultiple and Continuous Scheduling

https://community.cloudera.com/t5/Customer/FairScheduler-Tuning-With-assignmultiple-and-Continuous/ta-p/76442

### Recommendations
For larger clusters (having greater than 75-100 NodeManagers) seeing continuous workloads, use the following settings:

- Set the property `yarn.scheduler.fair.continuous-scheduling-enabled` to false
- Set the property `yarn.scheduler.fair.assignmultiple` to true

## Test

```
$ hadoop jar /opt/cloudera/parcels/CDH-.../jars/hadoop-examples.jar pi 50 50
```
