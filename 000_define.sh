#!/bin/bash
#This is config file for Quick Start Gentoo scripts https://github.com/ppv77/qsgentoo
#Don't delete if you wont use this as Stage4

debug=0
#----------------------------------------------------
#path to sudo or no sudo
sudo_cmd="/usr/bin/sudo"
#sudo_cmd=""

#--------------------------------------------------
#where script find files for chroot 
chroot_files="chroot_files"

#----------------------------------------------
#gentoo stage uri and file
#Stage3_uri="http://distfiles.gentoo.org/releases/amd64/autobuilds/current-install-amd64-minimal/"
Stage3_uri="http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/current-install-amd64-minimal/"
#Stage3_file="stage3-amd64-201*.tar.bz2"
Stage3_file="stage3-amd64-nomultilib-*.tar.bz2"

#---------------------------------------------------
#path to mount new rootfs
new_root="/mnt/gentoo"

#!!!!!!!!!!!!!!!!
main_device="/dev/sde"
#!!!!!!!!!!!!!!!!!!!!!!
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
mp[end,2]="40G"
mp[fs,2]="ext4"

#-------------------------------------------------------------------------------------------------------
#makeopts for emerge and kernel compile = cpu count
makeopts="-j16"

#--------------------------------------------------
#we already have distfiles? if livecd - no. new files will be stored
mount_distfiles=1
#distfiles_path="/var/calculate/remote/distfiles"
distfiles_path="/home/guest/for_stage4/distfiles"

#-----------------------------------------------------
#use and make pkg
use_packages=1
#if we have pkgs
#binhost="http://mirror.yandex.ru/calculate/grp/x86_64"

#we have local pkgs? new files will be stored
mount_packages=1
#packages_path="/var/calculate/packages/x86_64"
packages_path="/home/guest/for_stage4/packages"

#---------------------------------------------------
#use genkernel? alternative with dracut.
genkernel=0

#kernel config for non genkernel, or get from /proc/config.gz if no
#kernel_config=""
#kernel_config="config-photon-os-4.4.8"
#kernel_config="config-esx-minimal-4.9.16"
kernel_config="config-gentoo-livecd-4.9.16"

#do menuconfig?
menuconfig=0

#-------------------------
#add terminus-fonts and RU keyb
ru=0

#---------------------
#rm kernel sources
rm_linux_sources=1

#--------------------------
#generate stage4 file?
mk_stage4=1
