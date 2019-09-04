#!/bin/bash
#This is config file for Quick Start Gentoo scripts https://github.com/ppv77/qsgentoo
#Don't delete if you wont use this as Stage4


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!WARNING!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!
export main_device="/dev/sda"
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
export pt[type,1]="primary"
export pt[set,1]="bios_grub"
export pt[start,1]="1M"
export pt[end,1]="3M"
export pt[fs,1]=""
export pt[mp,1]=""

export pt[type,2]="primary"
export pt[set,2]="boot"
export pt[start,2]="3M"
export pt[end,2]="1G"
export pt[fs,2]="ext2"
export pt[mp,2]="/boot"

export pt[type,3]="primary"
export pt[set,3]=""
export pt[start,3]="1GM"
export pt[end,3]="3G"
export pt[fs,3]="swap"
export pt[mp,3]="swap"

export pt[type,4]="primary"
export pt[set,4]="lvm"
export pt[start,4]="3G"
export pt[end,4]="100%"
export pt[fs,4]="lvm"
export pt[mp,4]=""

# device			size		fs	mountpoint
#/dev/gentoo/rootfs		100%FREE	ext4	/

#lvm volumes
declare -A lv
#lvm volume group
export vg_name="gentoo"

export lv[name,1]="rootfs"
export lv[size,1]="-l100%FREE"
export lv[fs,1]="ext4"
export lv[mp,1]="/"





#----------------------------------------------
#gentoo stage uri and file
export Stage3_uri="http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/"
#or
#export Stage3_uri="http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/current-stage3-amd64/"

#----------------------------------------------
#export Stage3_file="stage3-amd64-201*.tar.xz"
#or
export Stage3_file="stage3-amd64-nomultilib-*.tar.xz"

#--------------------------------------
#add some USE
export use_flags="openssl"

#-----------------------------------------------------
#use and make pkg
export use_packages=0
#export binhost="some-url"


#---------------------------------------------------
#get kernel config from booted system  /proc/config.gz (recomended)
#export kernel=""
#or
#use kernel from livecd (very fast)
export kernel="livecd"
#or
#kernel config from some qsgentoo files
#export kernel="config-esx-minimal-4.9.16"

#do menuconfig?
export menuconfig=0

#-------------------------
#add terminus-fonts and RU keyb
export ru=0

#---------------------
#rm kernel sources
export rm_linux_sources=0

#----------------------
#remove stage3 file after unpack?
export rm_stage3=1

#--------------------------
#generate stage4 file?
export mk_stage4=0

#----------
#rm distfiles
export rm_distfiles=1

#------------
#rm portages
export rm_portages=0


#remove packages after install
export rm_packages=1


















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
[ $tester = 1 ] && rm_packages=0
[ $tester = 1 ] && rm_distfiles=0
[ $tester = 1 ] && binhost="http://www.stand.gis.lan/NAS00_shared/gentoo/packages/"




#[ $tester = 1 ] && kernel="livecd"
