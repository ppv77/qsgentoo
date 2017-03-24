#!/bin/bash 
. 000_define.sh

env-update ; . /etc/profile

emerge -u dev-vcs/git app-portage/eix dhcpcd e2fsprogs xfsprogs reiserfsprogs

eix-update
emerge -uND --verbose-conflicts @world
emerge  --depclean

printf "Europe/Moscow" >/etc/timezone
emerge --config sys-libs/timezone-data

locale-gen
eselect locale set en_US.utf8
env-update ; . /etc/profile

emerge -u  gentoo-sources

#see https://bugs.gentoo.org/show_bug.cgi?id=606154
emerge -C klibc
printf "=dev-libs/klibc-2.0.4 ~amd64\n" >>/etc/portage/package.accept_keywords/dev-lib_klibc
emerge -1 =dev-libs/klibc-2.0.4
emerge -u v86d
rm /etc/portage/package.accept_keywords/dev-lib_klibc

if [ $genkernel == 1  ] ; then
    emerge -u genkernel
    genkernel --menuconfig --loglevel=4 --install --makeopts=${makeopts} all
else
    emerge -u dracut
    cp /proc/config.gz /usr/src/linux
    pushd /usr/src/linux
    gunzip config.gz
    mv config .config
    #read -p Enter
    make olddefconfig
    make menuconfig
    #read -p Enter
    make ${makeopts} all
    #read -p Enter
    make modules_install
    #read -p Enter
    make install
    #read -p Enter
    dracut --kver $(make kernelversion) --force
    #read -p Enter
    popd
fi


emerge -u grub
#read -p Enter
grub-install ${main_device}
#read -p Enter
grub-mkconfig -o /boot/grub/grub.cfg
#read -p Enter

echo "root:root"| chpasswd
#emerge -u syslog-ng logrotate cronie 

