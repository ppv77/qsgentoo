#!/bin/bash
. 000_define.sh

if [ $mount_distfiles = 1 ] ; then
    sudo umount ${new_root}/usr/portage/distfiles
fi

if [ $mount_packages = 1 ] ; then
    sudo umount ${new_root}/usr/portage/packages
fi


sudo umount -l ${new_root}/proc
sudo umount -l ${new_root}/sys
sudo umount -l ${new_root}/dev{/shm,/pts,}

