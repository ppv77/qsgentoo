#!/bin/bash 
. 000_define.sh

${sudo_cmd} mv ${new_root}/etc/fstab  ${new_root}/etc/fstab.default
truncate --size 0 ${new_root}/etc/fstab

for (( i=1; i < ${#mp[@]}/4+1; i++ ))
do
    [ "${mp[mountpoint,$i]}" == "bios_grub" ] && continue
#fs
    printf "${main_device}$i		" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
#dir
    case "${mp[mountpoint,$i]}" in
	"swap" )
	    printf "none		" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
	    ;;
	* )
	    printf  "${mp[mountpoint,$i]}		" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
	    ;;
    esac
#type
    printf "${mp[fs,$i]}		" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
    
    
#options
    case "${mp[mountpoint,$i]}" in
	"swap" )
	    printf "sw		0		0" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
	    ;;
	"/" )
	    printf "noatime		0		1" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
	    ;;
	"/boot" )
	    printf "noauto,noatime	1		2" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
	    ;;
	* )
	    printf  "noatime		0		2" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
	    ;;
    esac
    
    printf "\n" | ${sudo_cmd} tee -a ${new_root}/etc/fstab >/dev/null
done
