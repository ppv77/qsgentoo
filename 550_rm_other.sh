#!/bin/bash 
. 000_define.sh


${sudo_cmd} rm ${new_root}/in_chroot_task.sh
${sudo_cmd} rm ${new_root}/000_define.sh
[ -f ${new_root}/.config ] && ${sudo_cmd} rm ${new_root}/.config
if [ $use_packages = 1 ] ; then
    ${sudo_cmd} rm ${new_root}/etc/portage/make.conf/binpkg
fi


printf "cd /usr/src/linux/ && make clean" | ${sudo_cmd} tee ${new_root}/clean.sh >/dev/null
${sudo_cmd} chmod +x ${new_root}/clean.sh
${sudo_cmd} chroot ${new_root}  /clean.sh
${sudo_cmd} rm ${new_root}/clean.sh
