# AWSでRHEL７を使った際に、ボリュームを拡大したにも関わらず、６GBしか認識されない問題に対する対応

sudo yum install git
sudo yum update -y nss curl libcurl
git clone https://github.com/cloudera/director-scripts.git
cd director-scripts/faster-bootstrap/scripts/provisioning
chmod +x rewrite_root_disk_partition_table.sh 
sudo yum install gdisk
sudo ./rewrite_root_disk_partition_table.sh
# 再起動後解決
df -h
