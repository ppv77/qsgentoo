#!/bin/bash 
. 000_define.sh

printf "dev-vcs/git\n" >>/var/lib/portage/world
sort /var/lib/portage/world|uniq >/var/lib/portage/world.new
mv /var/lib/portage/world.new /var/lib/portage/world

. addon_update_world.sh
git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git /var/db/repos/gentoo.new
rm -rf /var/db/repos/gentoo
mv /var/db/repos/gentoo.new /var/db/repos/gentoo

cat << EOF >/etc/portage/repos.conf/repos.conf
[gentoo]
location = /var/db/repos/gentoo.new
sync-type = git
sync-uri = https://github.com/gentoo-mirror/gentoo.git
auto-sync = yes
EOF
