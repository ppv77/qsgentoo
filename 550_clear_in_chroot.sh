#!/bin/bash 
. 000_define.sh

printf "Clean chroot.\n"

${sudo_cmd} truncate --size 0 ${new_root}/clean.sh
${sudo_cmd} chmod +x ${new_root}/clean.sh

[ $rm_linux_sources = 1 ] && printf "cd /usr/src/linux/ && make clean\nemerge -c linux-sources && emerge -c\n" | ${sudo_cmd} tee -a ${new_root}/clean.sh >/dev/null
${sudo_cmd} chroot ${new_root}  /clean.sh
${sudo_cmd} rm ${new_root}/clean.sh
