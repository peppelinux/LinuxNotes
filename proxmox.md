Comandi riepilogativi
====================
lvs
vgscan
lvscan
pvscan

Montare proxmox a freddo (per recupero vm da un lvm):
========================

vgscan
vgchange -ay
mkdir /media/USB
mount /dev/pve/root /media/USB/
mount /dev/cciss/c0d0p1 /media/USB/boot
mount -t proc proc /media/USB/proc/
mount -t sysfs sys /media/USB/sys
mount -o bind /dev /media/USB/dev
chroot /media/USB

Vedere il contenuto dei containers lxc
======================================
pct config 103
pvesm path local-lvm:vm-103-disk-1

lvmdiskscan
lvdisplay | more
# detto ciò:
mount /dev/pve/vm-103-disk-1 /test/

Montare una immagine raw kvm:
============================
# Create device maps from partition tables

kpartx -av /dev/pve/vm-102-disk-1

# add map pve-vm--102--disk--1p1 (251:15): 0 1024000 linear /dev/pve/vm-102-disk-1 2048
# add map pve-vm--102--disk--1p2 (251:16): 0 68177920 linear /dev/pve/vm-102-disk-1 1026048

# per detach
kpartx -dv /dev/pve/vm-102-disk-1

Montare una partizione in un file raw
==============================

# leggo i settori = 69206016
cfdisk vm-102-disk-1.raw
o
fdisk vm-102-disk-1.raw

# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# Device             Boot   Start      End  Sectors  Size Id Type
# vm-102-disk-1.raw1 *       2048  1026047  1024000  500M  7 HPFS/NTFS/exFAT
# vm-102-disk-1.raw2      1026048 69203967 68177920 32.5G  7 HPFS/NTFS/exFAT

# Calculate the offset from the start of the image to the partition start
# Sector size * Start = (in the case) 512 * 1026048 = 525336576

losetup -o 525336576 /dev/loop0 vm-102-disk-1.raw
mount /dev/loop0 /mnt/test