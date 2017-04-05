#!/bin/bash 
. 000_define.sh

${sudo_cmd} truncate --size 0 ${new_root}/tmp.sh
${sudo_cmd} chmod +x ${new_root}/tmp.sh

[ $debug = 1 ] && read -p Enter
printf "eix-sync\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
[ $debug = 1 ] && printf "read -p Enter\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
printf "emerge -avuND --with-bdeps=y --keep-going @world\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
[ $debug = 1 ] && printf "read -p Enter\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
printf "dispatch-conf\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
printf "emerge @preserved-rebuild\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
printf "dispatch-conf\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null
printf "emerge -a --depclean\n" | ${sudo_cmd} tee -a ${new_root}/tmp.sh >/dev/null


[ $debug = 1 ] && read -p Enter
${sudo_cmd} chroot ${new_root}  /tmp.sh
${sudo_cmd} rm ${new_root}/tmp.sh
[ $debug = 1 ] && read -p Enter
