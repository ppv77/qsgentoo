#!/bin/bash
. 000_define.sh

printf "Mount disks.\n"
${sudo_cmd} mkdir ${verbose} -p ${new_root}

#find root
for (( i=1; i < ${#pt[@]}/6+1; i++ ))
do
    [ "${pt[mp,$i]}" = "/" ] && ${sudo_cmd} mount ${verbose}  "${main_device}$i" "${new_root}${pt[mp,$i]}"
done

for (( i=1; i < ${#lv[@]}/4+1; i++ ))
do
    [ "${lv[mp,$i]}" = "/" ] && ${sudo_cmd} mount ${verbose}  "/dev/${vg_name}/${lv[name,$i]}" "${new_root}${lv[mp,$i]}"
done




#mount other
for (( i=1; i < ${#pt[@]}/6+1; i++ ))
do
    [ "${pt[mp,$i]}" = "/" ] && continue
    [ "${pt[mp,$i]}" = "" ] && continue
    [ "${pt[mp,$i]}" = "swap" ] && continue
    [ ! -d ${new_root}${pt[mp,$i]} ] && ${sudo_cmd} mkdir  ${verbose} -p ${new_root}${pt[mp,$i]}
    ${sudo_cmd} mount ${verbose}  "${main_device}$i" "${new_root}${pt[mp,$i]}"
done

for (( i=1; i < ${#lv[@]}/4+1; i++ ))
do
    [ "${lv[mp,$i]}" = "/" ] && continue
    [ "${lv[mp,$i]}" = "" ] && continue
    [ "${lv[mp,$i]}" = "swap" ] && continue
    [ ! -d ${new_root}${lv[mp,$i]} ] && ${sudo_cmd} mkdir  ${verbose} -p ${new_root}${lv[mp,$i]}
    ${sudo_cmd} mount ${verbose}  "/dev/${vg_name}/${lv[name,$i]}" "${new_root}${lv[mp,$i]}"
done

