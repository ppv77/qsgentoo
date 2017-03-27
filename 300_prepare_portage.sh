#!/bin/bash
. 000_define.sh
${sudo_cmd} mkdir -p ${new_root}/etc/portage/repos.conf
${sudo_cmd} cp ${chroot_files}/gentoo.conf ${new_root}/etc/portage/repos.conf/

${sudo_cmd} mkdir -p ${new_root}/etc/portage/package.accept_keywords

${sudo_cmd} mv ${new_root}/etc/portage/make.conf ${new_root}/etc/portage/make.conf.default
${sudo_cmd} mkdir -p ${new_root}/etc/portage/make.conf
${sudo_cmd} mv ${new_root}/etc/portage/make.conf.default ${new_root}/etc/portage/make.conf/make.conf.default
printf 'MAKEOPTS="'$makeopts'"' | ${sudo_cmd} tee  ${new_root}/etc/portage/make.conf/makeopts >/dev/null




