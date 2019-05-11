#!/usr/bin/env bash
year=$(date +"%Y" )
modulo=$(( $year % 2 ))

if [ $modulo -eq 0 ]; then
    echo "${year} is an even year"
    echo "Looking for RootkitRootBeer_EvenYear.E01"
    e01="RootkitRootBeer_EvenYear.E01"
    md5const="8af8a8706dcd00b4950a93fffc6c554e"
elif [ $modulo -eq 1 ]; then
    echo "${year} is an odd year"
    echo "Looking for RootkitRootBeer_OddYear.E01"
    e01="RootkitRootBeer_OddYear.E01"
    md5const="9fd88f81eaff1194a1a955786ca58dcf"
else
    echo "Failed to identify the current year; Please manually verify the MD5Hash"
    exit 1
fi

e01path="/home/sansforensics/Desktop/cases/$e01"
if test -f $e01path; then
    echo "$e01 found"
else
    echo "Couldn't find $e01 located at $e01path"
fi

echo "Now getting the md5 hash for $e01"
md5temp=$(md5sum $e01path | cut -c -32 )

if [ $md5temp == $md5const ]; then
    echo "Hash Verified"
else
    echo "Hash didn't match; please transfer e01 file to SIFT again"
fi
