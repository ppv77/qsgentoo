#!/bin/bash 
. 000_define.sh


sudo rm ${new_root}/in_chroot_task.sh
sudo rm ${new_root}/000_define.sh
sudo rm ${new_root}/k_config
if [ $use_packages = 1 ] ; then
    sudo rm ${new_root}/etc/portage/make.conf/binpkg
fi



