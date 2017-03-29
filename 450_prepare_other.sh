#!/bin/bash
. 000_define.sh

${sudo_cmd} cp 000_define.sh ${new_root}/
${sudo_cmd} cp ${chroot_files}/in_chroot_task.sh ${new_root}/
${sudo_cmd} cp /etc/resolv.conf ${new_root}/etc/
if [ $use_packages = 1 ] ; then
    ${sudo_cmd} cp ${chroot_files}/binpkg ${new_root}/etc/portage/make.conf
    printf 'PORTAGE_BINHOST="'$binhost'"' | ${sudo_cmd} tee -a ${new_root}/etc/portage/make.conf/binpkg >/dev/null
fi

if [ $ru = 1 ] ; then
    ${sudo_cmd} mv ${new_root}/etc/conf.d/consolefont ${new_root}/etc/conf.d/consolefont.default
    ${sudo_cmd} cp ${chroot_files}/consolefont ${new_root}/etc/conf.d/consolefont
    ${sudo_cmd} mv ${new_root}/etc/conf.d/keymaps ${new_root}/etc/conf.d/keymaps.default
    ${sudo_cmd} cp ${chroot_files}/keymaps ${new_root}/etc/conf.d/keymaps
fi

[ -f ${chroot_files}/${kernel_config} ] && ${sudo_cmd} cp ${chroot_files}/${kernel_config} ${new_root}/.config
