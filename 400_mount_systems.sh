#!/bin/bash
. 000_define.sh

printf "Mount systems.\n"

${sudo_cmd} mount  ${verbose} -t proc /proc ${new_root}/proc
${sudo_cmd} mount  ${verbose} --rbind /sys ${new_root}/sys
${sudo_cmd} mount  ${verbose} --make-rslave ${new_root}/sys
${sudo_cmd} mount  ${verbose} --rbind /dev ${new_root}/dev
${sudo_cmd} mount  ${verbose} --make-rslave ${new_root}/dev
${sudo_cmd} mount  ${verbose} --rbind / ${new_root}/mnt

if [ $mount_distfiles = 1 ] ; then
    [ ! -d ${new_root}/usr/portage/distfiles ] && ${sudo_cmd} mkdir  ${verbose} -p ${new_root}/usr/portage/distfiles
    ${sudo_cmd} mount  ${verbose} --rbind $distfiles_path ${new_root}/usr/portage/distfiles
fi

if [ $mount_packages = 1 ] ; then
    [ ! -d ${new_root}/usr/portage/packages ] && ${sudo_cmd} mkdir  ${verbose} -p ${new_root}/usr/portage/packages
    ${sudo_cmd} mount  ${verbose} --rbind $packages_path ${new_root}/usr/portage/packages
fi