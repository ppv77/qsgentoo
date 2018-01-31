#!/bin/bash 
. 000_define.sh

printf "dev-vcs/git\n" >>/var/lib/portage/world
sort /var/lib/portage/world|uniq >/var/lib/portage/world.new
mv /var/lib/portage/world.new /var/lib/portage/world

. addon_update_world.sh
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
