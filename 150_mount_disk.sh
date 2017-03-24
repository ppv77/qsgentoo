#!/bin/bash 
. 000_define.sh


#mount root
sudo mkdir -p /mnt/gentoo
for (( i=1; i < ${#mp[@]}/4+1; i++ ))
    do
        [ "${mp[mountpoint,$i]}" = "/" ] && sudo mount ${main_device}$i ${new_root}${mp[mountpoint,$i]}
    done

#mount other
for (( i=1; i < ${#mp[@]}/4+1; i++ ))
do
    case "${mp[mountpoint,$i]}" in
	"swap" )
#	    sudo swapon ${main_device}$i
	    ;;
	"/" )
	    ;;
	"grub" )
	    ;;
	* )
	    [ ! -d ${new_root}${mp[mountpoint,$i]} ] && sudo mkdir -p ${new_root}${mp[mountpoint,$i]}
	    sudo mount ${main_device}$i ${new_root}${mp[mountpoint,$i]}
	    ;;
    esac
    
done
