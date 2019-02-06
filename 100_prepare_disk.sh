#!/bin/bash
. 000_define.sh

printf "Prepare disks.\n"

read -p "All data on ${main_device} will be removed (y/n):" yn
[ $yn != "y" ] && exit
${sudo_cmd} dmsetup remove_all
${sudo_cmd} partx -u ${main_device}
${sudo_cmd} sgdisk --clear ${main_device}
${sudo_cmd} parted -a optimal -s ${main_device} mklabel gpt
for (( i=1; i < ${#pt[@]}/5+1; i++ ))
do
     ${sudo_cmd} parted -a optimal -s ${main_device} mkpart ${pt[type,$i]} ${pt[start,$i]} ${pt[end,$i]}
     ${sudo_cmd} parted -s ${main_device} set $i ${pt[set,$i]} on
    case "${pt[fs,$i]}" in
	"ext4" ) 
	    ${sudo_cmd} mkfs.ext4 -F ${quiet} ${verbose} ${main_device}$i
	    ;;
	"reiserfs" ) 
	    ${sudo_cmd} mkfs.reiserfs ${quiet} -f ${main_device}$i
	    ;;
	"xfs" ) 
	    ${sudo_cmd} mkfs.xfs -f ${quiet} ${main_device}$i
	    ;;
	"ext3" ) 
	    ${sudo_cmd} mkfs.ext3 -F ${quiet}  ${verbose} ${main_device}$i
	    ;;
	"ext2" ) 
	    ${sudo_cmd} mkfs.ext2 -F ${quiet} ${verbose} ${main_device}$i
	    ;;
	"swap" )
	    ${sudo_cmd} mkswap -f ${main_device}$i
	    ;;
	"lvm" )
	    ${sudo_cmd} rc-service lvmetad start -q
	    ${sudo_cmd} pvcreate ${main_device}$i -ff -y
	    ${sudo_cmd} vgcreate gentoo ${main_device}$i
	    ;;
	"" )
	    ;;
	* ) 
	    printf "${pt[fs,$i]} not supported by scripts\n"
	    ;;
    esac
done

for (( i=1; i < ${#lv[@]}/3+1; i++ ))
do
    ${sudo_cmd} lvcreate ${lv[size,$i]} -n ${lv[name,$i]} gentoo
done
	    ${sudo_cmd} rc-service lvmetad stop -q

    
#    [ "${mp[mountpoint,$i]}" == "/boot" ] && ${sudo_cmd} parted -a optimal -s ${main_device} set $i boot on
#    [ "${mp[mountpoint,$i]}" == "bios_grub" ] && ${sudo_cmd} parted -a optimal -s ${main_device} set $i bios_grub on
#    sleep 5
#    case "${mp[fs,$i]}" in
#	"ext4" ) 
#	    ${sudo_cmd} mkfs.ext4 -F ${quiet} ${verbose} ${main_device}$i
#	    ;;
#	"reiserfs" ) 
#	    ${sudo_cmd} mkfs.reiserfs ${quiet} -f ${main_device}$i
#	    ;;
#	"xfs" ) 
#	    ${sudo_cmd} mkfs.xfs -f ${quiet} ${main_device}$i
#	    ;;
#	"ext3" ) 
#	    ${sudo_cmd} mkfs.ext3 -F ${quiet}  ${verbose} ${main_device}$i
#	    ;;
#	"ext2" ) 
#	    ${sudo_cmd} mkfs.ext2 -F ${quiet} ${verbose} ${main_device}$i
#	    ;;
#	"swap" )
#	    ${sudo_cmd} mkswap -f ${main_device}$i
#	    ;;
#	"" )
#	    ;;
#	* ) 
#	    printf "${mp[fs,$i]} not supported by scripts\n"
#	    ;;
#    esac
    
#done
