#!/bin/bash
. 000_define.sh

sudo cp 000_define.sh ${new_root}/
sudo cp in_chroot_task.sh ${new_root}/
sudo cp /etc/resolv.conf ${new_root}/etc/
sudo cp locale.gen ${new_root}/etc/
if [ $use_packages = 1 ] ; then
    sudo cp binpkg ${new_root}/etc/portage/make.conf
    printf 'PORTAGE_BINHOST="'$binhost'"' | sudo tee -a ${new_root}/etc/portage/make.conf/binpkg >/dev/null
fi
