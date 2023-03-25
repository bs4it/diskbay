#!/bin/bash

bay=$1
ctrl_index="0"
device_base="/sys/devices/pci0000:00/0000:00:02.2/0000:02:00.0/host0/port-0:0/expander-0:0/"
if [ -z "$1" ];then
  echo ""
  echo "Usage: Get-Disk.sh XX"
  echo ""
  echo "Where XX corresponds to the bay you want to query."
  echo "The returned value is the corresponding device in the format /dev/sdX"
  exit 1
fi
bay=$((10#$bay))
allbays=$(find $device_base/port* -type f -name bay_identifier)
disk=""
for i in $allbays; do
  curbay=$(cat $i)
  if [ $curbay -eq $bay ];then
    disk=$(echo $i | rev | cut -d "/" -f 2 | cut -d "-" -f 1 | rev)":0"
    disk=$(lsscsi | grep $disk | rev | awk '{print $1}' | rev)
  fi
done

if ! [ -z "$disk" ];then
  echo $disk
else
  echo "No disk found on bay $1 of the enclosure"
fi
