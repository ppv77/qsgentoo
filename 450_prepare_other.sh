#!/bin/bash
. 000_define.sh

${sudo_cmd} cp 000_define.sh ${new_root}/
${sudo_cmd} cp ${chroot_files}/in_chroot_task.sh ${new_root}/
${sudo_cmd} cp ${chroot_files}/k_config ${new_root}/
${sudo_cmd} cp /etc/resolv.conf ${new_root}/etc/
${sudo_cmd} cp ${chroot_files}/locale.gen ${new_root}/etc/
if [ $use_packages = 1 ] ; then
    ${sudo_cmd} cp ${chroot_files}/binpkg ${new_root}/etc/portage/make.conf
    printf 'PORTAGE_BINHOST="'$binhost'"' | ${sudo_cmd} tee -a ${new_root}/etc/portage/make.conf/binpkg >/dev/null
fi

if [ $ru = 1 ] ; then
    ${sudo_cmd} mv ${chroot_files}/conf.d/consolefont ${chroot_files}/conf.d/consolefont.default
    ${sudo_cmd} cp ${chroot_files}/consolefont ${chroot_files}/conf.d/consolefont
    ${sudo_cmd} mv ${chroot_files}/conf.d/keymaps ${chroot_files}/conf.d/keymaps.default
    ${sudo_cmd} cp ${chroot_files}/keymaps ${chroot_files}/conf.d/keymaps
fi

${sudo_cmd} mv ${chroot_files}/default/grub ${chroot_files}/default/grub.default
${sudo_cmd} cp ${chroot_files}/grub ${chroot_files}/default/grub