#!/bin/bash
. 000_define.sh

${sudo_cmd} mount -t proc /proc ${new_root}/proc
${sudo_cmd} mount --rbind /sys ${new_root}/sys
${sudo_cmd} mount --make-rslave ${new_root}/sys
${sudo_cmd} mount --rbind /dev ${new_root}/dev
${sudo_cmd} mount --make-rslave ${new_root}/dev

if [ $mount_distfiles = 1 ] ; then
    [ ! -d ${new_root}/usr/portage/distfiles ] && ${sudo_cmd} mkdir -p ${new_root}/usr/portage/distfiles
    ${sudo_cmd} mount --rbind $distfiles_path ${new_root}/usr/portage/distfiles
fi

if [ $mount_packages = 1 ] ; then
    [ ! -d ${new_root}/usr/portage/packages ] && ${sudo_cmd} mkdir -p ${new_root}/usr/portage/packages
    ${sudo_cmd} mount --rbind $packages_path ${new_root}/usr/portage/packages
fi