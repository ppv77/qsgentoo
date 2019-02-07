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
#dev		name(mountpoint)	start		end	fs
#/dev/sdx1	bios_grub		1M		1G	no
#/dev/sdx2	/			1G		20G	ext4
#/dev/sdx3	/boot			20G		21G	ext2
#/dev/sdx4	swap			21G		22G	swap

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
pt[set,3]="lvm"
pt[start,3]="1G"
pt[end,3]="100%"
pt[fs,3]="lvm"
pt[mp,3]=""

#lvm volumes
declare -A lv
#lvm volume group
vg_name="gentoo"
lv[name,1]="swap"
lv[size,1]="-L2G"
lv[fs,1]="swap"
lv[mp,1]="swap"

lv[name,2]="rootfs"
lv[size,2]="-l100%FREE"
lv[fs,2]="ext4"
lv[mp,2]="/"





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
#use precompiled kernel from livecd (very fast)
kernel="livecd"
#or
#use precompiled kernel from url
#kernel="precompiled"
#precompiled_uri="http://url/"
#precompiled_file="4.9.16.tar.bz2"
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
devel=1
#!!!WARNING!!!!Only for tester host
tester=0

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
[ $tester = 1 ] && Stage3_uri="http://10.10.104.122/for_stage4/"
[ $devel = 1 ] && Stage3_uri="http://localhost/for_stage4/"

#portages
#------------------------------------
#where download portage? Not require.
#portage_zip="https://github.com/gentoo-mirror/gentoo/archive/stable.zip"
[ $tester = 1 ] && portage_zip="http://10.10.104.122/for_stage4/gentoo-stable.zip"
[ $devel = 1 ] && portage_zip="http://localhost/for_stage4/gentoo-stable.zip"

#destination
[ $devel = 1 ] && main_device="/dev/sdb"
[ $tester = 1 ] && main_device="/dev/sda"



#--------------------------------------------------
#we already have distfiles? if livecd - no. new files will be stored
mount_distfiles=0
[ $devel = 1 ] && mount_distfiles=1
distfiles_path="/var/www/localhost/for_stage4/distfiles"

[ $devel = 1 ] && use_packages=1
[ $devel = 1 ] && binhost="http://localhost/for_stage4/packages"

[ $tester = 1 ] && use_packages=1
[ $tester = 1 ] && binhost="http://10.10.104.122/for_stage4/packages"



#we have local pkgs? new files will be stored
mount_packages=0
[ $devel = 1 ] && mount_packages=1
#packages_path="/var/www/localhost/for_stage4/packages"
[ $devel = 1 ] && packages_path="/var/www/localhost/for_stage4/packages"


[ $devel = 1 ] && kernel="precompiled"
[ $devel = 1 ] && precompiled_uri="http://localhost/for_stage4/"
[ $devel = 1 ] && precompiled_file="4.9.16.tar.bz2"


[ $tester = 1 ] && kernel="livecd"
[ $tester = 1 ] && precompiled_uri="http://10.10.104.122/for_stage4/"
[ $tester = 1 ] && precompiled_file="4.9.16.tar.bz2"
