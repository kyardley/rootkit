#!/usr/bin/env bash
year=$(date +"%Y" )
modulo=$(( $year % 2 ))

if [ $modulo -eq 0 ]; then
    echo "${year} is an even year"
    echo "Looking for RootkitRootBeer_EvenYear.E01"
    e01="RootkitRootBeer_EvenYear.E01"
elif [ $modulo -eq 1 ]; then
    echo "${year} is an odd year"
    echo "Looking for RootkitRootBeer_OddYear.E01"
    e01="RootkitRootBeer_OddYear.E01"
else
    echo "Failed to identify the current year; Please mount E01 file manually"
    exit 1
fi

e01path="/home/sansforensics/Desktop/cases/$e01"
if test -f $e01path; then
    echo "$e01 found"
else
    echo "Couldn't find $e01 located at $e01path"
    exit 1
fi

echo "Now mounting E01 file"
sudo ewfmount $e01path /mnt/ewf_mount/
sudo mount -t ext4 -o ro,loop,noexec,noload,offset=1048576 /mnt/ewf_mount/ewf1 /mnt/e01

sudo touch /etc/init.d/rootkit-mount
sudo chmod +x /etc/init.d/rootkit-mount
echo "#!/bin/bash" >> /etc/init.d/rootkit-mount
echo "sudo ewfmount $e01path /mnt/ewf_mount/" >> /etc/init.d/rootkit-mount
echo "sudo mount -t ext4 -o ro,loop,noexec,noload,offset=1048576 /mnt/ewf_mount/ewf1 /mnt/e01" >> /etc/init.d/rootkit-mount

sudo update-rc.d rootkit-mount defaults
