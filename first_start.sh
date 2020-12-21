#!/bin/bash 
. 000_define.sh
emerge ${quiet} ${verbose} eix app-portage/gentoolkit app-admin/sudo virtual/linux-sources
eselect kernel set 1


eix-update
emerge ${quiet} ${verbose} ${ask} -uND --with-bdeps=y --keep-going @world
dispatch-conf
emerge ${verbose} ${quiet} ${ask} @preserved-rebuild
dispatch-conf
emerge ${verbose} ${quiet} ${ask} --depclean


gunzip -c /proc/config.gz >/usr/src/linux/.config
pushd /usr/src/linux/
make olddefconfig


make ${makeopts} all
make ${makeopts} modules_install
make ${makeopts} install
sleep 10
k_rel=$(make kernelrelease)
dracut --kver $k_rel -H --force
grub-mkconfig -o /boot/grub/grub.cfg
popd
