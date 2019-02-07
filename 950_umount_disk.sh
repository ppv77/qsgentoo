#!/bin/bash
. 000_define.sh

printf "Umount disks.\n"

${sudo_cmd} umount  ${verbose} -R ${new_root}
#${sudo_cmd} rc-service lvmetad stop ${quiet}

