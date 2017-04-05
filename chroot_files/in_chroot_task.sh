#!/bin/bash 
. 000_define.sh



printf "dev-vcs/git\n" >>/var/lib/portage/world
printf "app-portage/eix\n" >>/var/lib/portage/world
printf "net-misc/dhcpcd\n" >>/var/lib/portage/world
printf "sys-fs/e2fsprogs\n" >>/var/lib/portage/world
printf "sys-fs/reiserfsprogs\n" >>/var/lib/portage/world
printf "sys-fs/xfsprogs\n" >>/var/lib/portage/world
#printf "sys-apps/v86d\n" >>/var/lib/portage/world
printf "sys-boot/grub\n" >>/var/lib/portage/world
printf "app-admin/syslog-ng\n" >>/var/lib/portage/world
printf "app-admin/logrotate\n" >>/var/lib/portage/world
printf "sys-process/cronie\n" >>/var/lib/portage/world
[ $ru = 1 ] && printf "media-fonts/terminus-font\n" >>/var/lib/portage/world

#see https://bugs.gentoo.org/show_bug.cgi?id=606154
#printf "=dev-libs/klibc-2.0.4 ~amd64\n" >>/etc/portage/package.accept_keywords/dev-lib_klibc
#printf "=dev-libs/klibc-2.0.4-r2\n" >> /etc/portage/package.mask/dev-lib_klibc

env-update ; . /etc/profile
emerge -quND --verbose-conflicts @world
emerge  -q --depclean

#see https://bugs.gentoo.org/show_bug.cgi?id=606154
#rm /etc/portage/package.accept_keywords/dev-lib_klibc
#rm /etc/portage/package.mask/dev-lib_klibc

printf "Europe/Moscow" >/etc/timezone
emerge -q --config sys-libs/timezone-data

[ ! -f "/etc/locale.gen.default" ] && mv /etc/locale.gen /etc/locale.gen.default
printf "en_US ISO-8859-1\nen_US.UTF-8 UTF-8\n" >/etc/locale.gen
[ $ru = 1 ] && printf "ru_RU.UTF-8 UTF-8\nru_RU.KOI-8 KOI-8\nru_RU.CP1251 CP1251\nru_RU ISO-8859-5\n" >>/etc/locale.gen
locale-gen
eselect locale set en_US.utf8
env-update ; . /etc/profile
[ $debug = 1 ] && read -p Enter


case $kernel in
    "genkernel" )
	emerge -q virtual/linux-sources genkernel
	[ $menuconfig == 1 ] && genkernel --menuconfig --loglevel=4 --install --makeopts=${makeopts} all
	[ $menuconfig == 0 ] && genkernel --loglevel=4 --install --makeopts=${makeopts} all
    ;;
    "precompiled" )
	wget -q ${precompiled_uri}${precompiled_file}
	tar xjpf ${precompiled_file} && rm ${precompiled_file}
    ;;
    "livecd" )
	emerge -q dracut
	mkdir -p /lib64/modules
	cp -r /mnt/lib64/modules/$(uname -r)/ /lib64/modules/
	cp /mnt/mnt/cdrom/isolinux/gentoo /boot/vmlinuz-$(uname -r)
	cp /mnt/mnt/cdrom/isolinux/System-gentoo.map /boot/System.map-$(uname -r)
	dracut --kver $(uname -r)
    ;;
    * )
	emerge -q virtual/linux-sources dracut
	pushd /usr/src/linux >/dev/null
	[ -f "/.config" ] && cp /.config /usr/src/linux/
	[ ! -f "/.config" ] && cp  /proc/config.gz /usr/src/linux && gunzip config.gz && mv config .config
        make olddefconfig
	[ $menuconfig == 1 ] && make menuconfig
        make ${makeopts} all
        make modules_install
        make install
        sleep 10
	dracut --kver $(make kernelrelease) --force
        popd >/dev/null
    ;;

esac


printf "GRUB_DISABLE_RECOVERY=true\n" >>/etc/default/grub
printf "GRUB_DEFAULT=saved\n" >>/etc/default/grub
printf "GRUB_DISABLE_SUBMENU=y\n" >>/etc/default/grub
printf "GRUB_TIMEOUT=2\n" >>/etc/default/grub
printf 'GRUB_GFXMODE="1280x1024"\n' >>/etc/default/grub
printf 'GRUB_COLOR_NORMAL="white/black"\n' >>/etc/default/grub
printf 'GRUB_COLOR_HIGHLIGHT="magenta/black"\n' >>/etc/default/grub
printf "GRUB_GFXPAYLOAD_LINUX=keep\n" >>/etc/default/grub
printf 'GRUB_FONT="/usr/share/grub/unicode.pf2"\n' >>/etc/default/grub
printf 'GRUB_CMDLINE_LINUX="zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=30 video=1280x1024 vga=791  console=tty1 quiet"\n' >>/etc/default/grub
printf "GRUB_TERMINAL=console\n" >>/etc/default/grub
[ $debug = 1 ] && read -p Enter
grub-install ${main_device}
[ $debug = 1 ] && read -p Enter
grub-mkconfig -o /boot/grub/grub.cfg
[ $debug = 1 ] && read -p Enter
echo "root:root"| chpasswd

rc-update add syslog-ng default
rc-update add cronie default
[ $debug = 1 ] && read -p Enter

