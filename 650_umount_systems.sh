#!/bin/bash
. 000_define.sh

if [ $mount_distfiles = 1 ] ; then
    ${sudo_cmd} umount ${new_root}/usr/portage/distfiles
fi

if [ $mount_packages = 1 ] ; then
    ${sudo_cmd} umount ${new_root}/usr/portage/packages
fi


${sudo_cmd} umount -l ${new_root}/proc
${sudo_cmd} umount -l ${new_root}/sys
${sudo_cmd} umount -l ${new_root}/dev{/shm,/pts,}

