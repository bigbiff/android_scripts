#!/bin/bash

USAGE="USAGE: $0 imgfile"

OUTPUT="/home/bigbiff/twrp"

if [[ $1 == "" ]]
then
	echo $USAGE
	exit 1
fi

echo "Remember to name the file the same name you want"
echo "the odin tar.md5. Otherwise odin will fail"
echo "For example: instead of recovery.md5, openrecovery-twrp-2.3.0.3-sgh-i717.img"
TAR=`basename $1`
cp $1 /tmp/recovery.img
cd /tmp
#tar -H ustar -c $TAR > /tmp/$TAR.tar
tar -c recovery.img > /tmp/$TAR.tar
#md5sum -t $TAR.tar >> /tmp/$TAR.tar
#mv $TAR.tar $OUTPUT/$TAR.tar.md5
mv $TAR.tar $OUTPUT/$TAR.tar
