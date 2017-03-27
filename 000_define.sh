#!/bin/bash

chroot_files="chroot_files"
#Stage3_uri="http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/"
Stage3_uri="http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/current-stage3-amd64/"
Stage3_file="stage3-amd64-201*.tar.bz2"
new_root="/mnt/gentoo"

#mountpoints define
main_device="/dev/sde"
declare -A mp

mp[mountpoint,1]="bios_grub"
mp[start,1]="1M"
mp[end,1]="1G"
mp[fs,1]=""

mp[mountpoint,2]="/boot"
mp[start,2]="1G"
mp[end,2]="2G"
mp[fs,2]="ext2"

mp[mountpoint,3]="swap"
mp[start,3]="2G"
mp[end,3]="4G"
mp[fs,3]="swap"

mp[mountpoint,4]="/"
mp[start,4]="4G"
mp[end,4]="40G"
mp[fs,4]="ext4"

makeopts="-j16"

#portage_uri="portage/"
#portage_uri="https://github.com/gentoo-mirror/gentoo.git"

mount_distfiles=0
distfiles_path="/var/calculate/remote/distfiles"
use_packages=0
binhost="http://mirror.yandex.ru/calculate/grp/x86_64"
mount_packages=0
packages_path="/var/calculate/packages/x86_64"

genkernel=0
menuconfig=0
ru=1