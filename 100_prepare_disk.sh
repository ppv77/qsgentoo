#!/bin/bash
. 000_define.sh
function makefs(){
    case $1 in
	"ext4" )
	    ${sudo_cmd} mkfs.ext4 -F ${quiet} ${verbose} $2
	    ;;
	"reiserfs" )
	    ${sudo_cmd} mkfs.reiserfs ${quiet} -f $2
	    ;;
	"xfs" )
	    ${sudo_cmd} mkfs.xfs -f ${quiet} $2
	    ;;
	"ext3" ) 
	    ${sudo_cmd} mkfs.ext3 -F ${quiet}  ${verbose} $2
	    ;;
	"ext2" ) 
	    ${sudo_cmd} mkfs.ext2 -F ${quiet} ${verbose} $2
	    ;;
	"swap" )
	    ${sudo_cmd} mkswap -f $2
	    ;;
	"lvm" )
	    ${sudo_cmd} rc-service lvmetad start ${quiet}
	    ${sudo_cmd} pvcreate $2 -ff -y
	    ${sudo_cmd} vgcreate ${vg_name} $2
	    ;;
	"" )
	    ;;
	* ) 
	    printf "${pt[fs,$i]} not supported by scripts\n"
	    ;;
    esac
}

printf "Prepare disks.\n"
printf "All data on ${main_device} will be removed in 10 sec\n"
sleep 30
${sudo_cmd} rc-service lvmetad stop ${quiet}
${sudo_cmd} partx -u ${main_device}
${sudo_cmd} dmsetup remove_all
${sudo_cmd} wipefs -a ${quiet} ${main_device}
#${sudo_cmd} sgdisk --clear ${main_device}
${sudo_cmd} parted -a optimal -s ${main_device} mklabel gpt


for (( i=1; i < ${#pt[@]}/6+1; i++ ))
do
     ${sudo_cmd} parted -a optimal -s ${main_device} mkpart ${pt[type,$i]} ${pt[start,$i]} ${pt[end,$i]}
     [ "${pt[set,$i]}" = "" ] ||  ${sudo_cmd} parted -s ${main_device} set $i ${pt[set,$i]} on
     makefs "${pt[fs,$i]}" "${main_device}$i"

done



for (( i=1; i < ${#lv[@]}/4+1; i++ ))
do
    ${sudo_cmd} lvcreate ${lv[size,$i]} -n ${lv[name,$i]} ${vg_name} -y
     makefs "${lv[fs,$i]}" "/dev/mapper/${vg_name}-${lv[name,$i]}"
done
${sudo_cmd} rc-service lvmetad stop ${quiet}

