## odbc.ini
cat <<EOF >~/.odbc.ini
[Impala]

# Description: DSN Description.
# This key is not necessary and is only to give a description of the data source.
Description=Cloudera ODBC Driver for Apache Impala (64-bit) DSN

# Driver: The location where the ODBC driver is installed to.
Driver=/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so

# Values for HOST, PORT, HS2HostFQDN, and HS2KrbServiceName should be set here.
# They can also be specified on the connection string.
HOST=`hostname -A`
PORT=21050
AuthMech=1
KrbFQDN=i2.lab.cloudera.com
KrbRealm=HADOOP
KrbServiceName=impala
DelegationUID=test
EOF


LD_PRELOAD=/usr/lib64/libodbcinst.so isql Impala <<EOF
drop table t1
create table t1 (c1 int)
select count(*) from t1
quit
EOF
