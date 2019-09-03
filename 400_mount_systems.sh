#!/bin/bash
. 000_define.sh

printf "Mount systems.\n"

${sudo_cmd} mount  ${verbose} -t proc /proc ${new_root}/proc
${sudo_cmd} mount  ${verbose} --rbind /sys ${new_root}/sys
${sudo_cmd} mount  ${verbose} --make-rslave ${new_root}/sys
${sudo_cmd} mount  ${verbose} --rbind /dev ${new_root}/dev
${sudo_cmd} mount  ${verbose} --make-rslave ${new_root}/dev
${sudo_cmd} mount  ${verbose} --rbind / ${new_root}/mnt

