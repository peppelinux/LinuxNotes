https://github.com/thias/glim

http://www.slivermetal.org/2016/09/18/how-to-create-an-hybrid-uefi-gpt-bios-gptmbr-boot-usb-disk/

https://github.com/thias/glim

# first of all create a hybrid uefi gpt bios gptmbr boot disk!

git clone https://github.com/aguslr/multibootusb.git
cd multibootusb

bash makeUSB.sh /dev/sdb

then put isos in its /boot/iso folder

# these commands are useless with makeUSB.sh!
#export USBMNT=/mnt
#export USBDEV=sdb
#ensure that boot partition have bios_grub flag
#grub-install --boot-directory=${USBMNT:-/mnt}/boot /dev/${USBDEV}


