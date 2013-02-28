#!/bin/bash

USAGE="$0 imgfile"

if [[ $1 == "" ]]
then
	echo $USAGE
	exit 1
fi

file=$1
zip=$2
dir="/home/bigbiff/twrp"
newfile=`basename $file .img`
cp $file /tmp/recovery.img
cd /tmp
7z u $zip recovery.img 
cp $zip $dir/$newfile.zip 
rm /tmp/recovery.img
