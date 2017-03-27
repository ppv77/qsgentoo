#!/bin/bash
. 000_define.sh

sudo cp 000_define.sh ${new_root}/
sudo cp ${chroot_files}/in_chroot_task.sh ${new_root}/
sudo cp ${chroot_files}/k_config ${new_root}/
sudo cp /etc/resolv.conf ${new_root}/etc/
sudo cp ${chroot_files}/locale.gen ${new_root}/etc/
if [ $use_packages = 1 ] ; then
    sudo cp ${chroot_files}/binpkg ${new_root}/etc/portage/make.conf
    printf 'PORTAGE_BINHOST="'$binhost'"' | sudo tee -a ${new_root}/etc/portage/make.conf/binpkg >/dev/null
fi

if [ $ru = 1 ] ; then
    sudo mv ${chroot_files}/conf.d/consolefont ${chroot_files}/conf.d/consolefont.default
    sudo cp ${chroot_files}/consolefont ${chroot_files}/conf.d/consolefont
    sudo mv ${chroot_files}/conf.d/keymaps ${chroot_files}/conf.d/keymaps.default
    sudo cp ${chroot_files}/keymaps ${chroot_files}/conf.d/keymaps
fi

sudo mv ${chroot_files}/default/grub ${chroot_files}/default/grub.default
sudo cp ${chroot_files}/grub ${chroot_files}/default/grub