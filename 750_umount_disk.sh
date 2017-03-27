#!/bin/bash
. 000_define.sh

${sudo_cmd} umount -R ${new_root}

#for (( i=${#mp[@]}/4 ; i > 0 ; i-- ))
#do
#    case "${mp[mountpoint,$i]}" in
#	"swap" )
#	    ${sudo_cmd} swapoff ${main_device}$i
#	    ;;
#	* ) 
#	    ${sudo_cmd} umount ${main_device}$i
#	    ;;
#    esac
#    
#done
