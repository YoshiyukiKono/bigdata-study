# Sensor Data

## 実行準備

### Druid
```
cd apache-druid-0.15.0-incubating
./bin/start-micro-quickstart 
```

navigate to http://<host>:8888

### Kafka
```
cd kafka_2.12-2.1.0
./bin/kafka-server-start.sh config/server.properties
```
### Superset
```
$ python3 -m venv venv
$ . venv/bin/activate
(venv) [centos@ip-10-0-0-53 ~]$ superset runserver -d
```
navigate to http://<host>:8088
admin/admin

## Spec
https://viewse.blogspot.com/2019/06/minifinifihdfshive_5.html


「センサーID,**タイムスタンプ**,日付, 時間, 気圧, 温度, 湿度」のカンマ区切りのデータ

1,2019-06-04 23:59:51,2019-06-04,23:59:51,1011.54,24.86,50.67

## Data
Python Script
```
#coding: utf-8
#import bme280_custom
import datetime
import os

id = "1"
now = datetime.datetime.now()
timestamp = now.strftime('%Y-%m-%d %H:%M:%S')
now_ymd = now.strftime('%Y-%m-%d')
now_hms = now.strftime('%H:%M:%S')
sensor_data = "1011.54,24.86,50.67"
print(id+","+timestamp+","+now_ymd +","+now_hms+","+sensor_data)
```

```
./gen_sensor.py >> sensor.txt 
```

emu_sensor.py
```

```
```
import datetime
import os
import time
from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers=['localhost:9092'],
                         value_serializer=lambda x:
                         x.encode('utf-8'))
                         #dumps(x).encode('utf-8'))
                         #msgpack.dumps(x).encode('utf-8'))
while(True):
        id = "1"
        now = datetime.datetime.now()
        timestamp = now.strftime('%Y-%m-%d %H:%M:%S')
        now_ymd = now.strftime('%Y-%m-%d')
        now_hms = now.strftime('%H:%M:%S')
        sensor_data = "2,2,3"
        #sensor_data = "1011.54,24.86,50.67"
        pushed_data = id+","+timestamp+","+now_ymd +","+now_hms+","+sensor_data
        print(pushed_data)
        producer.send('sensor', value=pushed_data)
        time.sleep(1)
```

```
[centos@ip-10-0-0-53 ~]$ python3 -m venv sensor
[centos@ip-10-0-0-53 ~]$ . sensor/bin/activate
(sensor) [centos@ip-10-0-0-53 ~]$ pip install kafka-python
(sensor) [centos@ip-10-0-0-53 ~]$ python emu_sensor.py
```

## Kafka Topic

```
./bin/kafka-server-start.sh config/server.properties

./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic sensor

```

## Kafka Producer

```
./kafka_2.12-2.1.0/bin/kafka-console-producer.sh  --broker-list localhost:9092 --topic sensor < sensor.txt
```
```
python gen_sensor.py | ./kafka_2.12-2.1.0/bin/kafka-console-producer.sh  --broker-list localhost:9092 --topic sensor
```
## Supervisor Spec
```
{
  "type": "kafka",
  "dataSchema": {
    "dataSource": "sensor",
    "parser": {
      "type": "string",
      "parseSpec": {
        "format": "csv",
        "timestampSpec": {
          "column": "timestamp",
          "format": "auto"
        },
        "dimensionsSpec": {
          "dimensions": ["id","date","time",
          { "name" : "atmosphere", "type" : "long" },
          { "name" : "temperature", "type" : "long" },
          { "name" : "humidity", "type" : "long" } ]
        },
        "columns": [
          "id",
          "timestamp",
          "date",
          "time",
          "atmosphere",
          "temperature",
          "humidity"
        ]
      }
    },
    "metricsSpec": [],
    "granularitySpec": {
      "type": "uniform",
      "segmentGranularity": "HOUR",
      "queryGranularity": "NONE"
    }
  },
  "tuningConfig": {
    "type": "kafka",
    "maxRowsPerSegment": 5000000
  },
  "ioConfig": {
    "topic": "sensor",
    "consumerProperties": {
      "bootstrap.servers": "localhost:9092"
    },
    "taskCount": 1,
    "replicas": 1,
    "taskDuration": "PT1H"
  }
}

```
