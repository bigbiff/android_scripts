make $1
make clean CROSS_COMPILE=/home/bigbiff/android_prebuilt_toolchains/codesourcery/arm-2010.09/bin/arm-none-eabi- 
make  CROSS_COMPILE=/home/bigbiff/android_prebuilt_toolchains/codesourcery/arm-2010.09/bin/arm-none-eabi- ARCH=arm CONFIG_INITRAMFS_SOURCE=/data/repos/ramdisks/i317-ramdisk/ -j7 > error.txt 2>&1
