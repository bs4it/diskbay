#!/bin/bash

bay=$1
if [ -z "$1" ];then
  echo ""
  echo "Usage: Format-Disk.sh XX"
  echo ""
  echo "Where XX corresponds to the bay holding the disk you want to format."
  exit 1
fi
#bay=$((10#$bay))
bay=$(printf "%02d" $bay)

echo ""
echo "If you proceed the disk on the bay $bay will be unmounted and formated. All data on this disk will be PERMANENTELY LOST."
echo ""

while ! [[ $accept = 'Y' || $accept = 'y' || $accept = 'N' || $accept = 'n' ]]
do
	echo -n -e "Do you really want to go ahead? (Y/N):"
	read accept
	case $accept in
		y|Y)
			echo ""
			;;
		n|N)
			echo "Quitting, bye!"
			sleep 1
			exit 0
			;;
  	esac
done
# Getting device for bay
disk=$($(dirname "$0")/Get-Disk.sh $bay)
echo "Unmounting $disk ..."
umount --force $disk
sleep 1
echo "Wiping any data from $disk  ..."
wipefs -a -q $disk
sleep 1
echo "Formating $disk with label disk$bay ..."
mkfs.xfs -f -L disk$bay $disk
sleep 1
echo "Mounting all filesystems listed on /etc/fstab ..."
mount -a
sleep 1
echo "Setting ownership to minio-user ..."
chown minio-user:minio-user -R /disk$bay
sleep 1
echo "DONE!"

