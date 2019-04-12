# Package Installation
yum -y install git gcc gcc-c++ unixODBC-devel
wget https://downloads.cloudera.com/connectors/impala-2.5.22.1023/Linux/EL6/ClouderaImpalaODBC-2.5.22.1023-1.el6.x86_64.rpm
yum -y install ClouderaImpalaODBC-2.5.22.1023-1.el6.x86_64.rpm

echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib:/opt/cloudera/impalaodbc/lib/64:/usr/local/lib" >> ~/.bashrc
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib:/opt/cloudera/impalaodbc/lib/64:/usr/local/lib

echo "export CLOUDERAIMPALAINI=~/.cloudera.impalaodbc.ini" >> ~/.bashrc
export CLOUDERAIMPALAINI=~/.cloudera.impalaodbc.ini


# Create setting Files
## cloudera.impalaodbc.ini
cat <<EOF >~/.cloudera.impalaodbc.ini
[Driver]
 
## - Note that this default DriverManagerEncoding of UTF-32 is for iODBC.
## - unixODBC uses UTF-16 by default.
## - If unixODBC was compiled with -DSQL_WCHART_CONVERT, then UTF-32 is the correct value.
##   Execute 'odbc_config --cflags' to determine if you need UTF-32 or UTF-16 on unixODBC
## - SimbaDM can be used with UTF-8 or UTF-16.
##   The DriverUnicodeEncoding setting will cause SimbaDM to run in UTF-8 when set to 2 or UTF-16 when set to 1.
 
DriverManagerEncoding=UTF-32
ErrorMessagesPath=/opt/cloudera/impalaodbc/ErrorMessages/
LogLevel=0
LogPath=
 
 
## - Uncomment the ODBCInstLib corresponding to the Driver Manager being used.
## - Note that the path to your ODBC Driver Manager must be specified in LD_LIBRARY_PATH (LIBPATH for AIX).
 
#   SimbaDM / unixODBC
ODBCInstLib=libodbcinst.so
EOF

## odbcinst.ini
cat <<EOF >~/.odbcinst.ini
[ODBC Drivers]
Cloudera ODBC Driver for Impala 64-bit=Installed
 
[Cloudera ODBC Driver for Impala 64-bit]
Description=Cloudera ODBC Driver for Impala (64-bit)
Driver=/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so
EOF

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
EOF
