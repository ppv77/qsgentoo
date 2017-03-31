#!/bin/bash 
. 000_define.sh

${sudo_cmd} truncate --size 0 ${new_root}/tmp.sh
${sudo_cmd} chmod +x ${new_root}/tmp.sh

printf "app-misc/mc\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-admin/sudo\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-misc/screen\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "app-portage/gentoolkit\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null
printf "sys-process/htop\n" | ${sudo_cmd} tee -a ${new_root}/var/lib/portage/world >/dev/null

[ $debug = 1 ] && read -p Enter