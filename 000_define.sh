#!/bin/bash
#This is config file for Quick Start Gentoo scripts https://github.com/ppv77/qsgentoo
#Don't delete if you wont use this as Stage4


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!WARNING!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!
main_device="/dev/sda"
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!WARNING!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!



# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#mountpoints define-------------------------------------------------------------------------------------------
#samle disk
# gpt
# device		type		flag		start		end	fs	mountpoint
#/dev/sdx1		primary		bios_grub	1M		3M	no	no
#/dev/sdx2		primary		boot		3M		1G	ext2	/boot
#/dev/sdx3		primary		no		1G		3G	ext2	/boot
#/dev/sdx4		primary		lvm		3G		100%	lvm	no

#partitions
declare -A pt
pt[type,1]="primary"
pt[set,1]="bios_grub"
pt[start,1]="1M"
pt[end,1]="3M"
pt[fs,1]=""
pt[mp,1]=""

pt[type,2]="primary"
pt[set,2]="boot"
pt[start,2]="3M"
pt[end,2]="1G"
pt[fs,2]="ext2"
pt[mp,2]="/boot"

pt[type,3]="primary"
pt[set,3]=""
pt[start,3]="1GM"
pt[end,3]="3G"
pt[fs,3]="swap"
pt[mp,3]="swap"

pt[type,4]="primary"
pt[set,4]="lvm"
pt[start,4]="3G"
pt[end,4]="100%"
pt[fs,4]="lvm"
pt[mp,4]=""

# device			size		fs	mountpoint
#/dev/gentoo/rootfs		100%FREE	ext4	/

#lvm volumes
declare -A lv
#lvm volume group
vg_name="gentoo"

lv[name,1]="rootfs"
lv[size,1]="-l100%FREE"
lv[fs,1]="ext4"
lv[mp,1]="/"





#----------------------------------------------
#gentoo stage uri and file
Stage3_uri="http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/"
#or
#Stage3_uri="http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/current-stage3-amd64/"

#----------------------------------------------
#Stage3_file="stage3-amd64-201*.tar.xz"
#or
Stage3_file="stage3-amd64-nomultilib-*.tar.xz"

#--------------------------------------
#add some USE
use_flags="openssl"

#-----------------------------------------------------
#use and make pkg
use_packages=0
#binhost="some-url"

#---------------------------------------------------
#get kernel config from booted system  /proc/config.gz (recomended)
#kernel=""
#or
#use kernel from livecd (very fast)
kernel="livecd"
#or
#kernel config from some qsgentoo files
#kernel="config-esx-minimal-4.9.16"

#do menuconfig?
menuconfig=0

#-------------------------
#add terminus-fonts and RU keyb
ru=0

#---------------------
#rm kernel sources
rm_linux_sources=0

#----------------------
#remove stage3 file after unpack?
rm_stage3=1

#--------------------------
#generate stage4 file?
mk_stage4=0

#------------
#rm portages
rm_portages=0





















#############################################################################
############################################################################

#---------------------------------------------------
#path to mount new rootfs
new_root="/mnt/gentoo"

#-------------------------------------------------------------------------------------------------------
#makeopts for emerge and kernel compile = cpu count+1
cpus=$(grep -c process /proc/cpuinfo)
makeopts="-j$(($cpus+1))"



#!!!WARNING!!!!Only for development host
devel=0
#!!!WARNING!!!!Only for tester host
tester=1
wget -q -O /dev/null http://www.stand.gis.lan/NAS00_shared/gentoo/ || tester=0
wget -q -O /dev/null http://www.stand.gis.lan/NAS00_shared/gentoo/ || devel=0
[ $devel = 1 ] && echo DEVEL_HOST
[ $tester = 1 ] && echo TESTER_HOST

#verbose="-v"
#ask="-a"
debug=0
quiet="-q"
kernel_quiet="-s"

#--------------------------------------------------
#where script find files for chroot 
chroot_files="chroot_files"

soft_level=0
#[ $minimal = 1 ] && soft_level=0
#[ $minimal = 0 ] && soft_level=1
#[ $1 = "addons" ] && soft_level=2


#----------------------------------------------------
#path to sudo or no sudo
[ $devel = 1 ] && sudo_cmd="/usr/bin/sudo" || sudo_cmd=""

#stage uri
[ $tester = 1 ] && Stage3_uri="http://www.stand.gis.lan/NAS00_shared/gentoo/"
[ $devel = 1 ] && Stage3_uri="http://www.stand.gis.lan/NAS00_shared/gentoo/"

#portages
#------------------------------------
#where download portage? Not require.
#portage_zip="https://github.com/gentoo-mirror/gentoo/archive/stable.zip"
[ $tester = 1 ] && portage_zip="http://www.stand.gis.lan/NAS00_shared/gentoo/gentoo-stable.zip"
[ $devel = 1 ] && portage_zip="http://www.stand.gis.lan/NAS00_shared/gentoo/gentoo-stable.zip"

#destination
[ $devel = 1 ] && main_device="/dev/sdb"
[ $tester = 1 ] && main_device="/dev/sda"




#[ $devel = 1 ] && use_packages=1
#[ $devel = 1 ] && binhost="http://localhost/for_stage4/packages"

[ $tester = 1 ] && use_packages=1
[ $tester = 1 ] && binhost="http://www.stand.gis.lan/NAS00_shared/gentoo/packages/"






#[ $tester = 1 ] && kernel="livecd"
