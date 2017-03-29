#!/bin/bash
. 000_define.sh
[ ! -d "${new_root}/etc/portage/repos.conf" ] && ${sudo_cmd} mkdir -p ${new_root}/etc/portage/repos.conf
[ ! -f "${new_root}/etc/portage/repos.conf/gentoo.conf" ] && ${sudo_cmd} cp ${chroot_files}/gentoo.conf ${new_root}/etc/portage/repos.conf/

[ ! -d "${new_root}/etc/portage/package.accept_keywords" ] && ${sudo_cmd} mkdir -p ${new_root}/etc/portage/package.accept_keywords

[ -f "${new_root}/etc/portage/make.conf" ] && ${sudo_cmd} mv ${new_root}/etc/portage/make.conf ${new_root}/etc/portage/make.conf.default
[ ! -d "${new_root}/etc/portage/make.conf" ] && ${sudo_cmd} mkdir -p ${new_root}/etc/portage/make.conf
[ ! -f "${new_root}/etc/portage/make.conf/make.conf.default" ] && ${sudo_cmd} mv ${new_root}/etc/portage/make.conf.default ${new_root}/etc/portage/make.conf/make.conf.default
printf 'MAKEOPTS="'$makeopts'"\n' | ${sudo_cmd} tee  ${new_root}/etc/portage/make.conf/makeopts >/dev/null




