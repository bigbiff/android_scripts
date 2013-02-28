#!/bin/bash
export USE_CCACHE=1
export CCACHE=1
cd /data/repos/cm10/hardware/qcom/audio 
git fetch http://gerrit.sudoservers.com/AOKP/android_hardware_qcom_audio refs/changes/76/3276/1 && git checkout FETCH_HEAD
#cd /data/repos/cm10/system/bluetooth
#git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_bluetooth refs/changes/04/24004/1 && git checkout FETCH_HEAD
sleep 5
cd /data/repos/cm10
#cd /data/repos/pa
make clobber
#./rom-build.sh quincyatt
. ./build/envsetup.sh
brunch quincyatt
#cd ~/pa
#7z u /data/repos/pa/out/target/product/quincyatt/pa_quincyatt-2*.zip system/
#rm /data/www/note/*quincyatt-2*.zip
rm /data/www/note/*2*quincyatt-*.zip
#cp /data/repos/cm10/out/target/product/quincyatt/*quincyatt-2*.zip /data/www/note/
cp /data/repos/cm10/out/target/product/quincyatt/*2*quincyatt-*.zip /data/www/note/
