#!/bin/bash
. 000_define.sh

printf "Umount systems.\n"



if [ $mount_packages = 1 ] ; then
    ${sudo_cmd} umount  ${verbose} ${new_root}/usr/portage/packages
fi


${sudo_cmd} umount -l  ${verbose} ${new_root}/proc
${sudo_cmd} umount -l  ${verbose} ${new_root}/sys
${sudo_cmd} umount -l  ${verbose} ${new_root}/dev{/shm,/pts,}
${sudo_cmd} umount -l  ${verbose} ${new_root}/mnt
