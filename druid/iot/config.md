# Sensor Data
## Spec
https://viewse.blogspot.com/2019/06/minifinifihdfshive_5.html

2019-06-04.csv

中身は：「センサーID, 日付, 時間, 気圧, 温度, 湿度」のカンマ区切りのデータになります。

1,2019-06-04,23:59:51,1011.54,24.86,50.67

Pythonスクリプト
```
#coding: utf-8
#import bme280_custom
import datetime
import os

#dir_path = '/home/pi/bme280-data’
now = datetime.datetime.now()
now_ymd = now.strftime('%Y-%m-%d’)
now_hms = now.strftime('%H:%M:%S’)
#sensor_data = bme280_custom.readData()
sensor_data = "1011.54,24.86,50.67"
#if not os.path.exists('/home/pi/bme280-data’):
#　　os.makedirs('/home/pi/bme280-data’)
#f = open('/home/pi/bme280-data/'+filename+'.csv','a’)
f.write('1,'+now_ymd +","+now_hms+","+sensor_data+"\n")
f.close()
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
          { name" = : "atmosphere", "type" : "long" },
          { name" = : "temperature", "type" : "long" },
          { name" = : "humidity", "type" : "long" }
        }
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
    "maxRowsPerSegment": false
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
