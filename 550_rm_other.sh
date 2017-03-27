#!/bin/bash 
. 000_define.sh


${sudo_cmd} rm ${new_root}/in_chroot_task.sh
${sudo_cmd} rm ${new_root}/000_define.sh
${sudo_cmd} rm ${new_root}/k_config
if [ $use_packages = 1 ] ; then
    ${sudo_cmd} rm ${new_root}/etc/portage/make.conf/binpkg
fi



