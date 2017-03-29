#!/bin/bash 
. 000_define.sh

${sudo_cmd} truncate --size 0 ${new_root}/clean.sh
${sudo_cmd} chmod +x ${new_root}/clean.sh

printf "cd /usr/src/linux/ && make clean\n" | ${sudo_cmd} tee -a ${new_root}/clean.sh >/dev/null
[ $debug = 1 ] && read -p Enter
[ $rm_linux_sources = 1 ] && printf "emerge -c linux-sources && emerge -c\n" | ${sudo_cmd} tee -a ${new_root}/clean.sh >/dev/null
[ $debug = 1 ] && read -p Enter
${sudo_cmd} chroot ${new_root}  /clean.sh
${sudo_cmd} rm ${new_root}/clean.sh
[ $debug = 1 ] && read -p Enter