#!/bin/bash 
. 000_define.sh



printf "dev-vcs/git\n" >>/var/lib/portage/world
printf "app-portage/eix\n" >>/var/lib/portage/world
printf "net-misc/dhcpcd\n" >>/var/lib/portage/world
printf "sys-fs/e2fsprogs\n" >>/var/lib/portage/world
printf "sys-fs/reiserfsprogs\n" >>/var/lib/portage/world
printf "sys-fs/xfsprogs\n" >>/var/lib/portage/world
printf "sys-kernel/gentoo-sources\n" >>/var/lib/portage/world
[ $genkernel == 0  ] && printf "sys-kernel/dracut\n" >>/var/lib/portage/world
[ $genkernel == 1  ] && printf "sys-kernel/genkernel\n" >>/var/lib/portage/world
printf "sys-apps/v86d\n" >>/var/lib/portage/world
printf "sys-boot/grub\n" >>/var/lib/portage/world
printf "app-admin/syslog-ng\n" >>/var/lib/portage/world
printf "app-admin/logrotate\n" >>/var/lib/portage/world
printf "sys-process/cronie\n" >>/var/lib/portage/world
[ $ru = 1 ] && printf "media-fonts/terminus-font\n" >>/var/lib/portage/world

#see https://bugs.gentoo.org/show_bug.cgi?id=606154
printf "=dev-libs/klibc-2.0.4 ~amd64\n" >>/etc/portage/package.accept_keywords/dev-lib_klibc
printf "=dev-libs/klibc-2.0.4-r2\n" >> /etc/portage/package.mask/dev-lib_klibc

env-update ; . /etc/profile
eix-update
emerge -uND --verbose-conflicts @world
emerge  --depclean

#see https://bugs.gentoo.org/show_bug.cgi?id=606154
rm /etc/portage/package.accept_keywords/dev-lib_klibc
rm /etc/portage/package.mask/dev-lib_klibc

printf "Europe/Moscow" >/etc/timezone
emerge --config sys-libs/timezone-data

locale-gen
eselect locale set en_US.utf8
env-update ; . /etc/profile



if [ $genkernel == 1  ] ; then
    [ $menuconfig == 1 ] && genkernel --menuconfig --loglevel=4 --install --makeopts=${makeopts} all
    [ $menuconfig == 0 ] && genkernel --loglevel=4 --install --makeopts=${makeopts} all
    
else
    pushd /usr/src/linux
    [ -f "/.config" ] && cp  /usr/src/linux/
    [ ! -f "/.config" ] && cp  /proc/config.gz /usr/src/linux && gunzip config.gz && mv config .config
    read -p Enter
    make olddefconfig
    [ $menuconfig == 1 ] && make menuconfig
    #read -p Enter
    make ${makeopts} all
    #read -p Enter
    make modules_install
    #read -p Enter
    make install
    #read -p Enter
    sleep 10
    dracut --kver $(make kernelrelease) --force
    #read -p Enter
    popd
fi


printf "GRUB_DISABLE_RECOVERY=true\n" >>/etc/default/grub
printf "GRUB_DEFAULT=saved\n" >>/etc/default/grub
printf "GRUB_DISABLE_SUBMENU=y\n" >>/etc/default/grub
printf "GRUB_TIMEOUT=2\n" >>/etc/default/grub
printf 'GRUB_GFXMODE="1280x1024"\n' >>/etc/default/grub
printf 'GRUB_COLOR_NORMAL="white/black"\n' >>/etc/default/grub
printf 'GRUB_COLOR_HIGHLIGHT="magenta/black"\n' >>/etc/default/grub
printf "GRUB_GFXPAYLOAD_LINUX=keep\n" >>/etc/default/grub
printf 'GRUB_FONT="/usr/share/grub/unicode.pf2"\n' >>/etc/default/grub
printf 'GRUB_CMDLINE_LINUX="zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=30 video=1280x1024  elevator=cfq  splash=silent,theme:calculate console=tty1 quiet"\n' >>/etc/default/grub
printf "GRUB_TERMINAL=console\n" >>/etc/default/grub
#read -p Enter
grub-install ${main_device}
#read -p Enter
grub-mkconfig -o /boot/grub/grub.cfg
#read -p Enter

echo "root:root"| chpasswd

rc-update add syslon-ng
rc-update add cronie


