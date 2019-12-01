# Sqoop

http://archive.cloudera.com/cdh5/cdh/5/sqoop-1.4.6-cdh5.15.0/SqoopUserGuide.html

## Import

```
$ sqoop import --connect jdbc:mysql://<hostname>(:3306)/<dbname> --table <tablename> --username <username> --password <password> \
> -- target-dir <dirpath>
```

### Default configuration
- Format: text
- Separater: comma

## Help
```
$ sqoop help import
usage: sqoop import [GENERIC-ARGS] [TOOL-ARGS]

Common arguments:
   --connect <jdbc-uri>     Specify JDBC connect string
   --connect-manager <class-name>     Specify connection manager class to use
   --driver <class-name>    Manually specify JDBC driver class to use
   --hadoop-mapred-home <dir>      Override $HADOOP_MAPRED_HOME
   --help                   Print usage instructions
   --password-file          Set path for file containing authentication password
   -P                       Read password from console
   --password <password>    Set authentication password
   --username <username>    Set authentication username
   --verbose                Print more information while working
   --hadoop-home <dir>     Deprecated. Override $HADOOP_HOME

[...]

Generic Hadoop command-line arguments:
(must preceed any tool-specific arguments)
Generic options supported are
-conf <configuration file>     specify an application configuration file
-D <property=value>            use value for given property
-fs <local|namenode:port>      specify a namenode
-jt <local|jobtracker:port>    specify a job tracker
-files <comma separated list of files>    specify comma separated files to be copied to the map reduce cluster
-libjars <comma separated list of jars>    specify comma separated jar files to include in the classpath.
-archives <comma separated list of archives>    specify comma separated archives to be unarchived on the compute machines.

The general command line syntax is
bin/hadoop command [genericOptions] [commandOptions]
````

