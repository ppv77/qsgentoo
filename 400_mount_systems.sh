#!/bin/bash
. 000_define.sh

sudo mount -t proc /proc ${new_root}/proc
sudo mount --rbind /sys ${new_root}/sys
sudo mount --make-rslave ${new_root}/sys
sudo mount --rbind /dev ${new_root}/dev
sudo mount --make-rslave ${new_root}/dev

if [ $mount_distfiles = 1 ] ; then
    [ ! -d ${new_root}/usr/portage/distfiles ] && sudo mkdir -p ${new_root}/usr/portage/distfiles
    sudo mount --rbind $distfiles_path ${new_root}/usr/portage/distfiles
fi

if [ $mount_packages = 1 ] ; then
    [ ! -d ${new_root}/usr/portage/packages ] && sudo mkdir -p ${new_root}/usr/portage/packages
    sudo mount --rbind $packages_path ${new_root}/usr/portage/packages
fi