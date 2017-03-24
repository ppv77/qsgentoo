#!/bin/bash
. 000_define.sh
sudo mkdir -p ${new_root}/etc/portage/repos.conf
sudo cp gentoo.conf ${new_root}/etc/portage/repos.conf/

sudo mkdir -p ${new_root}/etc/portage/package.accept_keywords

sudo mv ${new_root}/etc/portage/make.conf ${new_root}/etc/portage/make.conf.default
sudo mkdir -p ${new_root}/etc/portage/make.conf
sudo mv ${new_root}/etc/portage/make.conf.default ${new_root}/etc/portage/make.conf/make.conf.default
printf 'MAKEOPTS="'$makeopts'"' | sudo tee  ${new_root}/etc/portage/make.conf/makeopts >/dev/null




