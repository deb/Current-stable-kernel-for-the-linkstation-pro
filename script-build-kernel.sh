# /bin/bash

#cp config from repo to .config in the kernel source directory FIRST

echo "please ensure that you have a good .config / kernel config ready"

echo "step 1 make clean"
make clean

echo "step 2 make menuconfig (edit this if you don't this step)"
make menuconfig

echo "step 3 make zImage .. this will take a while (you may want to use screen or another method to background this part)"
make zImage

echo "step 4 producing the required uImage for actual use from the zImage"
devio > foo 'wl 0xe3a01c06,4' 'wl 0xe3811031,4' # Linkstation Pro/Live
cat foo arch/arm/boot/zImage > zImage.new
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n 'linux' -d zImage.new uImage.new

rm foo zImage.new

echo "your kernel is ready (it is called uImage.new) HOWEVER YOU NOW NEED TO WAIT FOR THE MODULES TO BE BUILT AND INSTALLED"

echo "step 5 building modules"
make  modules

echo "step 6 installing modules"
make  modules_install 

echo "step 7 you now need to copy the uImage.new to /boot and symlink the uImage.buffalo to point at the uImage.new file"

echo "after rebooting, the kernel built should be active "



 




