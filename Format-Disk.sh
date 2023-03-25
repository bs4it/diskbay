#!/bin/bash

bay=$1
if [ -z "$1" ];then
  echo ""
  echo "Usage: Format-Disk.sh XX"
  echo ""
  echo "Where XX corresponds to the bay holding the disk you want to format."
  exit 1
fi
bay=$((10#$bay))

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

disk=$($(dirname "$0")/Get-Disk.sh $bay)
echo $disk
