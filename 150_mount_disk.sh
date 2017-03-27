#!/bin/bash 
. 000_define.sh


#mount root
${sudo_cmd} mkdir -p /mnt/gentoo
for (( i=1; i < ${#mp[@]}/4+1; i++ ))
    do
        [ "${mp[mountpoint,$i]}" = "/" ] && ${sudo_cmd} mount ${main_device}$i ${new_root}${mp[mountpoint,$i]}
    done

#mount other
for (( i=1; i < ${#mp[@]}/4+1; i++ ))
do
    case "${mp[mountpoint,$i]}" in
	"swap" )
#	    ${sudo_cmd} swapon ${main_device}$i
	    ;;
	"/" )
	    ;;
	"bios_grub" )
	    ;;
	* )
	    [ ! -d ${new_root}${mp[mountpoint,$i]} ] && ${sudo_cmd} mkdir -p ${new_root}${mp[mountpoint,$i]}
	    ${sudo_cmd} mount ${main_device}$i ${new_root}${mp[mountpoint,$i]}
	    ;;
    esac
    
done
