#!/bin/bash 
. 000_define.sh

printf "Clear system.\n"

${sudo_cmd} rm  ${verbose} ${new_root}/in_chroot_task.sh
${sudo_cmd} rm  ${verbose} ${new_root}/000_define.sh
${sudo_cmd} cp  ${verbose} 000_define.sh ${new_root}/root
${sudo_cmd} cp  ${verbose} logfile ${new_root}/root
#${sudo_cmd} cp  ${verbose} addon* ${new_root}/root
#${sudo_cmd} cp  ${verbose} first* ${new_root}/root

[ -f ${new_root}/.config ] && ${sudo_cmd} rm  ${verbose} ${new_root}/.config
if [ $rm_packages = 1 ] ; then
    ${sudo_cmd} rm  ${verbose} ${new_root}/etc/portage/make.conf/binpkg
    ${sudo_cmd} rm  ${verbose} -Rf ${new_root}/var/cache/binpkgs/*
fi

[ $rm_distfiles = 1 ] && ${sudo_cmd} rm  ${verbose} -Rf ${new_root}/var/cache/distfiles/*
[ $rm_portages = 1 ] && ${sudo_cmd} rm  ${verbose} -Rf ${new_root}/var/db/repos/gentoo/*


