#!/bin/bash 
. 000_define.sh

${sudo_cmd} truncate --size 0 ${new_root}/tmp.sh
${sudo_cmd} chmod +x ${new_root}/tmp.sh

printf "app-misc/mc\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-admin/sudo\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-misc/screen\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-portage/gentoolkit\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "sys-process/htop\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-admin/syslog-ng\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-admin/logrotate\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "sys-process/cronie\n"  | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "sys-fs/lvm2\n"  | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null

. tools_502_update_world.sh




rc-update add syslog-ng default
rc-update add cronie default
[ $debug = 1 ] && read -p Enter
