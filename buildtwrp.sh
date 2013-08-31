#!/bin/bash

TWRPCM10REPO=/data/repos/cm10-twrp
TWRPCM101REPO=/builds/cm10.1-twrp
TWRPOUTDIR=/home/bigbiff/twrp
cm101devices=('t03g' 't0ltecan' 't0lte' 't0ltetmo' 't0lteatt' 't0ltespr' 't0ltevzw' 't03gduoszn' 't0lteskt' 't0ltektt' 't03gub' 't0lteusc')
cm10devices=('quincyatt' 'quincytmo')

contains() {
	local i j=$1
	shift
	for i
	do
		[[ $i == $j ]] && return 0
	done
	return 1
}

if [[ $1 != "" ]]
then
	devices=( $(echo "$1") )
else
	n=${#cm101devices[@]}
	for ((i=0;i<n;i++)) {
		#devices[$i]=${cm101devices[$i]}"["${cm10devices[$i]}"]"
		devices[$i]=${cm101devices[$i]}
	}
	o=${#cm10devices[@]}
	p=`expr $n + $o`
	d=0
	for ((i=n;i<p;i++)) {
		 devices[$i]=${cm10devices[$d]}
		d=`expr $d + 1`
	}
fi

echo ${devices[*]}

for dev in ${devices[*]}
do
	$(contains $dev ${cm101devices[*]})
	if [[ $? == 0 ]]
	then
		cd $TWRPCM101REPO
		ver=$(grep TW_VERSION_STR $TWRPCM101REPO/bootable/recovery/variables.h | awk '{print $3}' | sed 's/"//g')
	fi
	$(contains $dev ${cm10devices[@]}) 
	if [[ $? == 0 ]]
	then
		cd $TWRPCM10REPO
		ver=$(grep TW_VERSION_STR $TWRPCM10REPO/bootable/recovery/variables.h | awk '{print $3}' | sed 's/"//g')
	fi
	. ./build/envsetup.sh
	lunch cm_$dev-eng  > /dev/null 2>&1
	make clobber && make recoveryimage -j7 > /home/bigbiff/twrp/logs/build-$dev.log  2>&1
	cp out/target/product/$dev/recovery.img $TWRPOUTDIR/openrecovery-twrp-$ver-$dev.img
	createodin.sh $TWRPOUTDIR/openrecovery-twrp-$ver-$dev.img
	bash -x createtwrpzip.sh $TWRPOUTDIR/openrecovery-twrp-$ver-$dev.img $TWRPOUTDIR/recovery-$dev.zip
	for i in `ls $TWRPOUTDIR/ | grep ".*open.*$dev\.?*"`
	do
		if [[ $dev == "quincyatt" ]]
		then
			devdir=sgh-i717
		elif [[ $dev == "quincytmo" ]]
		then
			devdir=sgh-t879
		else
			devdir=$dev
		fi
		rsync -avz --progress $TWRPOUTDIR/$i techerrata.com:~/twrp2/$devdir
		rsync -avz --progress $TWRPOUTDIR/$i OpenRecovery@upload.goo.im:~/public_html/$devdir 
	done
done
wget -qO- http://techerrata.com/update_index
wget -qO- http://goo.im/update_index 

