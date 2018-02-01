#!/bin/bash
. 000_define.sh

printf "Umount disks.\n"

${sudo_cmd} umount  ${verbose} -R ${new_root}

for (( i=1; i < ${#mp[@]}/4+1; i++ ))
do
    [ ${mp[mountpoint,$i]} = "swap" ] && ${sudo_cmd} swapoff ${verbose} ${main_device}$i
done

