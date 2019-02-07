#!/bin/bash 
. 000_define.sh

printf "Prepare fstab.\n"

${sudo_cmd} mv  ${verbose} ${new_root}/etc/fstab  ${new_root}/etc/fstab.default
${sudo_cmd} truncate --size 0 ${new_root}/etc/fstab


for (( i=1; i < ${#pt[@]}/6+1; i++ ))
do
    [ "${pt[mp,$i]}" = "" ] && continue
    [ "${pt[mp,$i]}" = "swap" ] && printf "${main_device}$i		none		swap		sw		0	0\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null && continue
    [ "${pt[mp,$i]}" = "/boot" ] && printf "${main_device}$i		${pt[mp,$i]}	${pt[fs,$i]}		defaults,noatime		0	2\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null && continue
    printf "${main_device}$i		${pt[mp,$i]}	${pt[fs,$i]}		noatime		0	1\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
done


for (( i=1; i < ${#lv[@]}/4+1; i++ ))
do
    [ "${lv[mp,$i]}" = "" ] && continue
    [ "${lv[mp,$i]}" = "swap" ] && printf "/dev/${vg_name}/${lv[name,$i]}		none		swap		sw		0	0\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null && continue
    [ "${lv[mp,$i]}" = "/boot" ] && printf "/dev/${vg_name}/${lv[name,$i}		${lv[mp,$i]}	${lv[fs,$i]}		defaults,noatime,noauto	0	2\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null && continue
    printf "/dev/${vg_name}/${lv[name,$i]}		${lv[mp,$i]}	${lv[fs,$i]}		noatime		0	1\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
done
printf "\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
