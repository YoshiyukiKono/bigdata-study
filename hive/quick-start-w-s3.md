# Hive Quick Start

## 基本動作確認

データ

http://stat-computing.org/dataexpo/2009/supplemental-data.html

http://stat-computing.org/dataexpo/2009/airports.csv


```
drop table airports;
create external table airports (iata string, airport string, city string, state string, country string, lat_val string, long_val string)
row format delimited fields terminated by ',' lines terminated by '\n'
 LOCATION '/tmp/airport'
 tblproperties ('skip.header.line.count'='1');
 
 select * from airports;
```

## S3
https://www.cloudera.com/documentation/enterprise/5-15-x/topics/admin_s3_config.html

```
create table airports_s3 (iata string, airport string, city string, state string, country string, lat_val string, long_val string)
row format delimited fields terminated by ',' lines terminated by '\n'
 LOCATION 's3a://kono-demo/airport'
 tblproperties ('skip.header.line.count'='1');
 
select * from airports_s3;
```
