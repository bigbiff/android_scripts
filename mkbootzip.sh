rm /home/bigbiff/pa/kernel/kernel.zip
rm /home/bigbiff/pa/kernel/system/lib/modules/*
cp out/target/product/quincyatt/kernel /home/bigbiff/pa/kernel/zImage
find out/target/product/quincyatt/system/lib/modules -name *.ko -exec cp {} /home/bigbiff/pa/kernel/system/lib/modules \;
cd /home/bigbiff/pa/kernel
7z u kernel.zip META-INF/ mkbootfs mkbootimg system/ unpackbootimg zImage
