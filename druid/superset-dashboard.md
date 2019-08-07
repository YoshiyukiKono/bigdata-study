# Real-time Dashboard 

## Tutorial
https://druid.apache.org/docs/latest/tutorials/tutorial-kafka.html

On Host
```
curl -O https://archive.apache.org/dist/kafka/2.1.0/kafka_2.12-2.1.0.tgz
tar -xzf kafka_2.12-2.1.0.tgz
cd kafka_2.12-2.1.0

./bin/kafka-server-start.sh config/server.properties

./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic wikipedia
```
From Druid Console
```
{
  "type": "kafka",
  "dataSchema": {
    "dataSource": "wikipedia",
    "parser": {
      "type": "string",
      "parseSpec": {
        "format": "json",
        "timestampSpec": {
          "column": "time",
          "format": "auto"
        },
        "dimensionsSpec": {
          "dimensions": [
            "channel",
            "cityName",
            "comment",
            "countryIsoCode",
            "countryName",
            "isAnonymous",
            "isMinor",
            "isNew",
            "isRobot",
            "isUnpatrolled",
            "metroCode",
            "namespace",
            "page",
            "regionIsoCode",
            "regionName",
            "user",
            { "name": "added", "type": "long" },
            { "name": "deleted", "type": "long" },
            { "name": "delta", "type": "long" }
          ]
        }
      }
    },
    "metricsSpec" : [],
    "granularitySpec": {
      "type": "uniform",
      "segmentGranularity": "DAY",
      "queryGranularity": "NONE",
      "rollup": false
    }
  },
  "tuningConfig": {
    "type": "kafka",
    "reportParseExceptions": false
  },
  "ioConfig": {
    "topic": "wikipedia",
    "replicas": 2,
    "taskDuration": "PT10M",
    "completionTimeout": "PT20M",
    "consumerProperties": {
      "bootstrap.servers": "localhost:9092"
    }
  }
}
```


## Kafka Producer
```
./kafka_2.12-2.1.0/bin/kafka-console-producer.sh  --broker-list localhost:9092 --topic wikipedia < apache-druid-0.15.0-incubating/quickstart/tutorial/wikiticker-2015-09-12-sampled.json
```

## Superset Configuration
Create your chart (time granularity: 1 minute, time range: Last 1 hour) and add it to a new dashboard.
Then you should be able to set auto refresh interval (every 30 seconds) on that dashboard -> right-above drowdownlist -> Set auto-reflesh interval

https://stackoverflow.com/questions/55073406/can-superset-support-real-time-dashboards


## Reference

Apache Kafka + Druidを使ってインタラクティブに時系列データを集計処理してみた

https://laclefyoshi.hatenablog.com/entry/20141221/1419164493

Apache Superset-Building Dashboard-Chart 10-Time Series Line Chart-Variation 2

https://www.youtube.com/watch?v=5CBDE5cWwPw
