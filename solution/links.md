## On NiFi by Timothy Spann

Enterprise IIoT: Edge Processing with Apache NiFi, MiniFi, TensorFlow, Apache MXNet

https://community.hortonworks.com/articles/183151/enterprise-iiot-edge-processing-with-apache-nifi-m.html

Integrating Apache MXNet Model Server with Apache NiFi - Updated

https://community.hortonworks.com/articles/202236/integrating-apache-mxnet-model-server-with-apache.html

Using Apache NiFi with Apache MXNet GluonCV for YOLO 3 Deep Learning Workflows

https://community.hortonworks.com/articles/222367/using-apache-nifi-with-apache-mxnet-gluoncv-for-yo.html

tspannhw/nifi-tensorflow-processor

Example Tensorflow Processor using Java API for Apache NiFi 1.2 - 1.9.1+ http://dataflowdeveloper.com

https://github.com/tspannhw/nifi-tensorflow-processor

Building a Custom Processor in Apache NiFi 1.5 for TensorFlow Using the Java API

https://community.hortonworks.com/content/kbentry/116803/building-a-custom-processor-in-apache-nifi-12-for.html

### EDGE MANAGEMENT DOCUMENTATION

https://docs.hortonworks.com/HDPDocuments/CEM/CEM-1.0.0/index.html

## Superset by Timothy Spann

https://community.hortonworks.com/articles/80412/working-with-airbnbs-superset.html

### Hortonworks Documentation

Accessing data using Apache Druid

https://docs.hortonworks.com/HDPDocuments/HDP3/HDP-3.0.1/adding-druid/content/druid_visualize_data.html

### Real time analytics: Divolte + Kafka + Druid + Superset

Githubから全ての環境をセットアップできる。

https://blog.godatadriven.com/divolte-kafka-druid-superset

```
git clone https://github.com/Fokko/divolte-kafka-druid-superset.git
cd divolte-kafka-druid-superset
git submodule update --init --recursive
docker-compose rm -f && docker-compose build && docker-compose up
```

1. yumに失敗
1. sudo付ける
1. docker-composeのパスが
