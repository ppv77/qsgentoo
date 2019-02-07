#!/bin/bash 
. 000_define.sh

[ $devel = 0 ] && [ $tester = 0 ] && emerge-webrsync ${quiet} ${verbose}
#emerge-webrsync ${quiet} ${verbose}

emerge  ${ask} ${quiet} dracut lvm2
case $kernel in
    "precompiled" )
	printf "Download precompiled kernel.\n"
	wget -nv ${quiet} ${precompiled_uri}${precompiled_file}
	tar ${verbose} -xjpf ${precompiled_file} && rm ${precompiled_file}
    ;;
    "livecd" )
	printf "Using kernel from livecd.\n"
	mkdir -p /lib64/modules
	cp -r /mnt/mnt/livecd/lib64/modules/$(uname -r) /lib64/modules/
	cp /mnt/mnt/cdrom/isolinux/gentoo /boot/vmlinuz-$(uname -r)
	cp /mnt/mnt/cdrom/isolinux/System-gentoo.map /boot/System.map-$(uname -r)
	dracut --kver $(uname -r)
    ;;
    * )
	printf "Compile kernel.\n"
	emerge  ${ask} ${quiet} virtual/linux-sources
	pushd /usr/src/linux >/dev/null
	[ -f "/.config" ] && cp /.config /usr/src/linux/
	[ ! -f "/.config" ] && cp  /proc/config.gz /usr/src/linux && gunzip config.gz && mv config .config
        make ${kernel_quiet} olddefconfig
	[ $menuconfig == 1 ] && make menuconfig
        make  ${kernel_quiet} ${makeopts} all
        make  ${kernel_quiet} modules_install
        make  ${kernel_quiet} install
        sleep 10
	dracut ${quiet} --kver $(make kernelrelease) --force
        popd >/dev/null
    ;;

esac



printf "Prepare world.\n"

printf "sys-fs/e2fsprogs\n" >>/var/lib/portage/world
printf "sys-fs/reiserfsprogs\n" >>/var/lib/portage/world
printf "sys-fs/xfsprogs\n" >>/var/lib/portage/world
printf "sys-boot/grub\n" >>/var/lib/portage/world
[ $ru = 1 ] && printf "media-fonts/terminus-font\n" >>/var/lib/portage/world
#if [ $soft_level > 0 ]; then
#    printf "sys-apps/pciutils\n" >>/var/lib/portage/world
#    printf "virtual/linux-sources\n" >>/var/lib/portage/world
    printf "net-misc/netifrc\n" >>/var/lib/portage/world
#    printf "sys-kernel/linux-firmware\n" >>/var/lib/portage/world
#    printf "sys-fs/xfsprogs\n" >>/var/lib/portage/world
#    printf "sys-fs/jfsutils\n" >>/var/lib/portage/world
#    printf "sys-fs/dosfstools\n" >>/var/lib/portage/world
#    printf "sys-fs/btrfs-progs\n" >>/var/lib/portage/world
#    printf "sys-fs/reiserfsprogs\n" >>/var/lib/portage/world
#    printf "sys-fs/e2fsprogs\n" >>/var/lib/portage/world
#    printf "app-admin/syslog-ng\n" >>/var/lib/portage/world
#    printf "sys-process/cronie\n" >>/var/lib/portage/world
    printf "net-misc/dhcpcd\n" >>/var/lib/portage/world
#    printf "net-dialup/ppp\n" >>/var/lib/portage/world
#    printf "net-wireless/iw\n" >>/var/lib/portage/world
#    printf "net-wireless/wpa-supplicant\n" >>/var/lib/portage/world
#fi

sort /var/lib/portage/world|uniq >/var/lib/portage/world.new
mv /var/lib/portage/world.new /var/lib/portage/world

env-update ; . /etc/profile
emerge  ${ask} ${quiet} ${verbose} -uND --verbose-conflicts @world
emerge   ${ask} ${quiet} ${verbose} --depclean


#if [ $soft_level > 0 ]; then
#    rc-update add syslog-ng default
#    rc-update add cronie default
#fi

printf "Set Timezone.\n"

printf "Europe/Moscow" >/etc/timezone
emerge  ${ask} ${quiet} --config sys-libs/timezone-data

printf "Set locale.\n"

[ ! -f "/etc/locale.gen.default" ] && mv /etc/locale.gen /etc/locale.gen.default
printf "en_US ISO-8859-1\nen_US.UTF-8 UTF-8\n" >/etc/locale.gen
[ $ru = 1 ] && printf "ru_RU.UTF-8 UTF-8\nru_RU.KOI-8 KOI-8\nru_RU.CP1251 CP1251\nru_RU ISO-8859-5\n" >>/etc/locale.gen
locale-gen
eselect locale set en_US.utf8

#printf "Convert portage to git.\n"

#rm -rf /usr/portage
#git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git /usr/portage
#env-update ; . /etc/profile
#[ $debug = 1 ] && read -p Enter





printf "Prepare Grub.\n"

printf "GRUB_DISABLE_RECOVERY=true\n" >>/etc/default/grub
printf "GRUB_DEFAULT=saved\n" >>/etc/default/grub
printf "GRUB_DISABLE_SUBMENU=y\n" >>/etc/default/grub
printf "GRUB_TIMEOUT=2\n" >>/etc/default/grub
printf 'GRUB_GFXMODE="1280x1024"\n' >>/etc/default/grub
printf 'GRUB_COLOR_NORMAL="white/black"\n' >>/etc/default/grub
printf 'GRUB_COLOR_HIGHLIGHT="magenta/black"\n' >>/etc/default/grub
printf "GRUB_GFXPAYLOAD_LINUX=keep\n" >>/etc/default/grub
printf 'GRUB_FONT="/usr/share/grub/unicode.pf2"\n' >>/etc/default/grub
printf 'GRUB_CMDLINE_LINUX="dolvm zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=30 video=1280x1024 vga=791  console=tty1 quiet"\n' >>/etc/default/grub
printf "GRUB_TERMINAL=console\n" >>/etc/default/grub
[ $debug = 1 ] && read -p Enter
grub-install ${main_device}
[ $debug = 1 ] && read -p Enter
grub-mkconfig -o /boot/grub/grub.cfg
[ $debug = 1 ] && read -p Enter

printf "Set root password root.\n"

echo "root:root"| chpasswd

[ $debug = 1 ] && read -p Enter

