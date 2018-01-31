#!/bin/bash
exec &> >(tee -i -a logfile)
#This is config file for Quick Start Gentoo scripts https://github.com/ppv77/qsgentoo
#Don't delete if you wont use this as Stage4

#!!!WARNING!!!!Only for development host
devel=1
#!!!WARNING!!!!Only for tester host
tester=0

debug=1



#--------------------------------------------------
#where script find files for chroot 
chroot_files="chroot_files"

#----------------------------------------------
#gentoo stage uri and file
Stage3_uri="http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/"
#Stage3_uri="http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/current-stage3-amd64/"
#Stage3_file="stage3-amd64-201*.tar.xz"
Stage3_file="stage3-amd64-nomultilib-*.tar.xz"
#remove stage3 file after unpack?
rm_stage3=1

#------------------------------------
#where download portage? or get from git if not defined (warning!!! no git on gentoo-livecd)
#portage_zip=""
#portage_zip="https://github.com/gentoo-mirror/gentoo/archive/stable.zip"

#---------------------------------------------------
#path to mount new rootfs
new_root="/mnt/gentoo"

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!WARNING!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!1
main_device="/dev/sda"
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#mountpoints define-------------------------------------------------------------------------------------------
#this for 40G disk
# gpt
#dev		name(mountpoint)	start		end	fs
#/dev/sdx1	bios_grub		1M		1G	no
#/dev/sdx2	/boot			1G		2G	ext2
#/dev/sdx3	swap			2G		4G	swap
#/dev/sdx4	/			4G		40G	ext4

declare -A mp

mp[mountpoint,1]="bios_grub"
mp[start,1]="1M"
mp[end,1]="1G"
mp[fs,1]=""

#mp[mountpoint,2]="/boot"
#mp[start,2]="1G"
#mp[end,2]="2G"
#mp[fs,2]="ext2"

#mp[mountpoint,3]="swap"
#mp[start,3]="2G"
#mp[end,3]="4G"
#mp[fs,3]="swap"

#mp[mountpoint,4]="/"
#mp[start,4]="4G"
#mp[end,4]="40G"
#mp[fs,4]="ext4"

mp[mountpoint,2]="/"
mp[start,2]="1G"
mp[end,2]="30G"
mp[fs,2]="ext4"

#-------------------------------------------------------------------------------------------------------
#makeopts for emerge and kernel compile = cpu count
makeopts="-j3"

#-----------------------------------------------------
#use and make pkg
use_packages=0
#binhost="some-url"

#---------------------------------------------------
#use genkernel?
#kernel="genkernel"
#use precompiled kernel from livecd
kernel="livecd"
#use precompiled kernel from url
#kernel="precompiled"
#precompiled_uri="http://url/"
#precompiled_file="4.9.16.tar.bz2"
#kernel config for non genkernel, or get from /proc/config.gz if no
#kernel=""
#kernel="config-photon-os-4.4.8"
#kernel="config-esx-minimal-4.9.16"
#kernel="config-gentoo-livecd-4.9.16"

#do menuconfig?
menuconfig=0

#-------------------------
#add terminus-fonts and RU keyb
ru=0

#---------------------
#rm kernel sources
rm_linux_sources=0

#--------------------------
#generate stage4 file?
mk_stage4=0




#############################################################################
############################################################################

[ $debug = 1 ] && verbose="-v" || quiet="-q"

#----------------------------------------------------
#path to sudo or no sudo
[ $devel = 1 ] && sudo_cmd="/usr/bin/sudo" || sudo_cmd=""

#stage uri
[ $tester = 1 ] && Stage3_uri="http://10.10.104.122/for_stage4/"
[ $devel = 1 ] && Stage3_uri="http://localhost/for_stage4/"

#portages
[ $tester = 1 ] && portage_zip="http://10.10.104.122/for_stage4/stable.zip"
[ $devel = 1 ] && portage_zip="http://localhost/for_stage4/stable.zip"

#destination
[ $devel = 1 ] && main_device="/dev/sdb"
[ $tester = 1 ] && main_device="/dev/sda"

#CPUs
[ $devel = 1 ] && makeopts="-j9"
[ $tester = 1 ] && makeopts="-j17"


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


[ $tester = 1 ] && kernel="precompiled"
[ $tester = 1 ] && precompiled_uri="http://10.10.104.122/for_stage4/"
[ $tester = 1 ] && precompiled_file="4.9.16.tar.bz2"
