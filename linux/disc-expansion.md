# AWSでRHEL７を使った際に、ボリュームを拡大したにも関わらず、６GBしか認識されない問題に対する対応

```
sudo yum install git
sudo yum update -y nss curl libcurl
git clone https://github.com/cloudera/director-scripts.git
cd director-scripts/faster-bootstrap/scripts/provisioning
chmod +x rewrite_root_disk_partition_table.sh 
sudo yum install gdisk
sudo ./rewrite_root_disk_partition_table.sh
# 再起動後解決
df -h
```

## Link
* https://serverfault.com/questions/610973/how-to-increase-the-size-of-an-xfs-file-system
* https://serverfault.com/questions/610973/how-to-increase-the-size-of-an-xfs-file-system
* https://dev.classmethod.jp/cloud/aws/centos6-trap/
* http://blog.serverworks.co.jp/tech/2015/08/27/extend-ebs-with-growpart/
* https://stackoverflow.com/questions/11014584/ec2-cant-resize-volume-after-increasing-size
* https://aftercore.net/2014/07/15/aws%E4%B8%8A%E3%81%AEred-hat-7-%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E6%8B%A1%E5%BC%B5-2/
* https://qiita.com/mimumemo/items/1820be501b59ee204d21

上記はいずれも、直接解決には繋がらなかったが、参考情報として記録する。

## rewrite_root_disk_partition_table.sh 引用

VIRTUALIZATION_TYPEは、事前設定が必要（パブリック・クラウドが設定）？
結果的には、事前のステップなどはなしで、ボリューム拡大確認の実績あり。
```
#!/bin/sh
# Generic script for resizing the root disk partition for a cloud virtual machine

set -o pipefail
set -x

# Just use resize2fs if this is a paravirtual VM and exit.
if [ "$VIRTUALIZATION_TYPE" = "pv" ]; then
    resize2fs $(sudo mount | grep "on / type" | awk '{ print $1 }')
    exit 0
fi

# Display the current size of all the available block devices

lsblk
df -h

# Detect the name of the root device. Xen is "/dev/xvda", KVM and VMWare is "/dev/sda",
# OpenStack is "/dev/vda"

ROOT_PARTITION_DEVICE=$(findmnt -n --evaluate -o SOURCE --target /)
ROOT_DEVICE=$(echo $ROOT_PARTITION_DEVICE | sed -e "s/\(p\|\)[0-9]*$//")
ROOT_DEVICE_TYPE=$(findmnt -n --evaluate -o FSTYPE --target /)

# If the root partition is already using 95% or more of the root device skip the resize operation

ROOT_DEVICE_SIZE=$(blockdev --getsize64 ${ROOT_DEVICE})
ROOT_PARTITION_SIZE=$(blockdev --getsize64 ${ROOT_PARTITION_DEVICE})

USAGE_PERCENTAGE=$((${ROOT_PARTITION_SIZE} * 100 / ${ROOT_DEVICE_SIZE}))

if [ "${USAGE_PERCENTAGE}" -gt "95" ]; then
    echo "No resize needed. The root disk partition already has the desired size"
    # http://www.tldp.org/LDP/abs/html/exitcodes.html
    exit 0
fi

# Detect if the root partition is GPT or MBR (the strategy is different)

if ! (fdisk -l "${ROOT_DEVICE}" 2>/dev/null | grep -q -i 'GPT'); then

    # MBR partitions can be resized using fdisk or parted by rewriting the partition table

    ROOT_PARTITION="${ROOT_DEVICE}1"
    ROOT_PARTITION_INFO="$(sfdisk -u S -l "${ROOT_DEVICE}" | grep "${ROOT_PARTITION}")"
    if echo "$ROOT_PARTITION_INFO" | grep -q '*'; then
        BOOTABLE='*'
    else
        BOOTABLE='-'
    fi
    START_SECTOR="$(echo "$ROOT_PARTITION_INFO" | awk '{print $3}')"

    sfdisk "${ROOT_DEVICE}" -u S --no-reread --force <<EOF
${START_SECTOR},,,${BOOTABLE}
0,0
0,0
0,0
EOF

else

    # GPT partitions require gdisk for resizing.

    # Get first non-BIOS boot (filesystem EF02) partition
    PARTITION_INFO=$(sgdisk -p ${ROOT_DEVICE} | grep "^\\s*[[:digit:]]" | grep -vi EF02 | head -n 1)

    # Get partition number, starting sector, and filesystem of the first non-BIOS boot partition
    PARTITION_NUMBER=$(echo ${PARTITION_INFO} | cut -d' ' -f 1)
    STARTING_SECTOR=$(echo ${PARTITION_INFO} | cut -d' ' -f 2)
    FILESYSTEM=$(echo ${PARTITION_INFO} | cut -d' ' -f 6)

    PARTITION_GUID_INFO=$(sgdisk -i ${PARTITION_NUMBER} ${ROOT_DEVICE} | grep "unique GUID")
    PARTITION_GUID=$(echo ${PARTITION_GUID_INFO##*:})
    PARTITION_NAME_INFO=$(sgdisk -i ${PARTITION_NUMBER} ${ROOT_DEVICE} | grep "Partition name")
    PARTITION_NAME=$(echo ${PARTITION_NAME_INFO##*:} | sed -e "s/^'//" -e "s/'$//" -e "s/\"/\\\"/g"  -e "s/\"/\\\\\"/g")

    sgdisk -e -d ${PARTITION_NUMBER} -n ${PARTITION_NUMBER}:${STARTING_SECTOR}:0 \
           -c ${PARTITION_NUMBER}:"${PARTITION_NAME}" -u ${PARTITION_NUMBER}:${PARTITION_GUID} \
           -t ${PARTITION_NUMBER}:${FILESYSTEM} ${ROOT_DEVICE}

fi

# cloud-init does not guarantee the resizing of an instance, so we will attempt to grow the
# instance after a reboot.

if [ "$ROOT_DEVICE_TYPE" = "xfs" ]; then
    echo "xfs_growfs /" >> /etc/rc.local
else
    echo "resize2fs \"${ROOT_PARTITION_DEVICE}\"" >> /etc/rc.local
fi

# /etc/rc.local is not necessarily marked executable on RHEL/CentOS 7, so we ensure that it is
chmod +x /etc/rc.local

exit 0
```


