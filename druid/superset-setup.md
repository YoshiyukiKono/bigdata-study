# Superset インストール

```
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install python36u python36u-libs python36u-devel python36u-pip
sudo ln -s /usr/bin/pip3.6 /usr/local/bin/pip
sudo rm -i /usr/bin/python
sudo ln -s /usr/bin/python3.6 /usr/local/bin/python3

sudo yum upgrade python-setuptools
sudo yum install gcc gcc-c++ libffi-devel python-devel python-pip python-wheel openssl-devel libsasl2-devel openldap-devel

sudo pip install virtualenv

python3 -m venv venv
. venv/bin/activate

pip install --upgrade setuptools pip

# Install superset
pip install superset
```
下記コマンドは事前準備がないとエラーになる。下記参照。
```
# Create an admin user (you will be prompted to set a username, first and last name before setting a password)
fabmanager create-admin --app superset
```
fabmanager is going to be deprecated in 2.2.X, you can use the same commands on the improved 'flask fab <command>'
Username [admin]: admin
User first name [admin]: admin
User last name [user]: user
Email [admin@fab.org]: ykono@cloudera.com
Password:(admin) 
Repeat for confirmation:(admin) 
Was unable to import superset Error: cannot import name '_maybe_box_datetimelike'

https://github.com/apache/incubator-superset/issues/6770

```
pip uninstall pandas
pip install pandas==0.23.4

# Create an admin user (you will be prompted to set a username, first and last name before setting a password)
fabmanager create-admin --app superset
```

Recognized Database Authentications.
Admin User admin created.


```
# Initialize the database
superset db upgrade
```

    "Can't determine which FROM clause to join "
sqlalchemy.exc.InvalidRequestError: Can't determine which FROM clause to join from, there are multiple FROMS which can join to this entity. Try adding an explicit ON clause to help resolve the ambiguity.

エラーも出ているが...一旦無視。

```
# Load some data to play with
superset load_examples

# Create default roles and permissions
superset init

# To start a development web server on port 8088, use -p to bind to another port
superset runserver -d
```

http://<host>:8088

Error:
sqlalchemy.exc.OperationalError
sqlalchemy.exc.OperationalError: (sqlite3.OperationalError) no such table: user_attribute
[SQL: SELECT user_attribute.welcome_dashboard_id AS user_attribute_welcome_dashboard_id 
FROM user_attribute 
WHERE user_attribute.user_id = ?]
[parameters: ('1',)]
(Background on this error at: http://sqlalche.me/e/e3q8)

https://github.com/apache/incubator-superset/issues/7143

```
pip install sqlalchemy==1.2.18

superset db upgrade

```
エラー出なくなった。

```
superset load_examples
```
時間をかけてロードするようになった
```
# Create default roles and permissions
superset init

# To start a development web server on port 8088, use -p to bind to another port
superset runserver -d
```

http://<host>:8088

ログイン成功
