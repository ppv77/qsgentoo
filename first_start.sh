#!/bin/bash 
. 000_define.sh
emerge ${quiet} ${verbose} eix dev-vcs/git app-portage/gentoolkit app-admin/sudo virtual/linux-sources
eselect kernel set 1

#eix bug
chown portage /var/cache/eix


git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git /usr/portage.new
rm -rf /usr/portage
mv /usr/portage.new /usr/portage

cat << EOF >/etc/portage/repos.conf/repos.conf
[gentoo]
location = /usr/portage
sync-type = git
sync-uri = https://github.com/gentoo-mirror/gentoo.git
auto-sync = yes
EOF


eix-update
emerge ${quiet} ${verbose} ${ask} -uND --with-bdeps=y --keep-going @world
dispatch-conf
emerge ${verbose} ${quiet} ${ask} @preserved-rebuild
dispatch-conf
emerge ${verbose} ${quiet} ${ask} --depclean


gunzip -c /proc/config.gz >/usr/src/linux/.config
pushd /usr/src/linux/
make olddefconfig


make -j10 all
make -j10 modules_install
make -j10 install
make -j10 firmware_install
sleep 10
k_rel=$(make kernelrelease)
dracut --kver $k_rel --force
mv /boot/initramfs-$k_rel.img /boot/initramfs-$k_rel-rescue.img
ln -s /boot/vmlinuz-$k_rel  /boot/vmlinuz-$k_rel-rescue
dracut --kver $k_rel -H --force
grub-mkconfig -o /boot/grub/grub.cfg
popd
