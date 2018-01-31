#!/bin/bash 
. 000_define.sh

printf "virtual/linux-sources\n" >>/var/lib/portage/world
printf "app-admin/sudo\n" >>/var/lib/portage/world
printf "app-portage/gentoolkit\n" >>/var/lib/portage/world
printf "app-portage/eix\n" >>/var/lib/portage/world
printf "app-admin/syslog-ng\n" >>/var/lib/portage/world
printf "app-admin/logrotate\n" >>/var/lib/portage/world
printf "sys-process/cronie\n" >>/var/lib/portage/world
sort /var/lib/portage/world|uniq >/var/lib/portage/world.new
mv /var/lib/portage/world.new /var/lib/portage/world

. addon_update_world.sh




rc-update add syslog-ng default
rc-update add cronie default
