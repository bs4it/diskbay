#!/bin/bash
ctrl_index="0"
device_base="/sys/devices/pci0000:00/0000:00:02.2/0000:02:00.0/host0/port-0:0/expander-0:0/"
ctl=$(lsblk -n -o HCTL $1 | cut -d ":" -f 1-3)
if [ -z "$1" ];then
  echo "Usage: Get-Bay.sh /dev/sdX"
  echo "the returned number corresponds to the baywhere disk sdX dis placed"
  exit 1
fi

file="/sys/devices/pci0000:00/0000:00:02.2/0000:02:00.0/host0/port-0:0/expander-0:0/port-$ctl/end_device-$ctl/sas_device/end_device-$ctl/bay_identifier"
if test -f "$file"; then
  bay=$(cat $file)
  bay=$(printf "%02d" $bay)
  echo $bay
else
  echo "$1 not found"
fi
