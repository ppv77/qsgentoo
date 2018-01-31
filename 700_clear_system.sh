#!/bin/bash 
. 000_define.sh

printf "Clear system.\n"

${sudo_cmd} rm  ${verbose} ${new_root}/in_chroot_task.sh
${sudo_cmd} rm  ${verbose} ${new_root}/000_define.sh
[ -f ${new_root}/.config ] && ${sudo_cmd} rm  ${verbose} ${new_root}/.config
if [ $use_packages = 1 ] ; then
    ${sudo_cmd} rm  ${verbose} ${new_root}/etc/portage/make.conf/binpkg
fi

#${sudo_cmd} rm -Rf ${new_root}/usr/portage/gentoo/*
${sudo_cmd} rm  ${verbose} -Rf ${new_root}/usr/portage/distfiles/*
${sudo_cmd} rm  ${verbose} -Rf ${new_root}/usr/portage/packages/*



