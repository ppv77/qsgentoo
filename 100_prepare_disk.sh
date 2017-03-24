#!/bin/bash 
. 000_define.sh


read -p "All data on ${main_device} will be removed (y/n):" yn
[ $yn != "y" ] && exit

sudo parted -s ${main_device} mklabel gpt
for (( i=1; i < ${#mp[@]}/4+1; i++ ))
do
    sudo parted -s ${main_device} mkpart ${mp[mountpoint,$i]} ${mp[start,$i]} ${mp[end,$i]}
    [ "${mp[mountpoint,$i]}" == "/boot" ] && sudo parted -s ${main_device} set $i boot on
    [ "${mp[mountpoint,$i]}" == "grub" ] && sudo parted -s ${main_device} set $i bios_grub on
    sleep 5
    case "${mp[fs,$i]}" in
	"ext4" ) 
	    sudo mkfs.ext4 -F -q ${main_device}$i
	    ;;
	"reiserfs" ) 
	    sudo mkfs.reiserfs -q -f ${main_device}$i
	    ;;
	"xfs" ) 
	    sudo mkfs.xfs -f -q ${main_device}$i
	    ;;
	"ext3" ) 
	    sudo mkfs.ext3 -F -q ${main_device}$i
	    ;;
	"ext2" ) 
	    sudo mkfs.ext2 -F -q ${main_device}$i
	    ;;
	"swap" )
	    sudo mkswap -f ${main_device}$i
	    ;;
	* ) 
	    printf "${mp[fs,$i]} not supported by scripts\n"
	    ;;
    esac
    
done
