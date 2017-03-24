#!/bin/bash
. 000_define.sh

sudo umount -R ${new_root}

#for (( i=${#mp[@]}/4 ; i > 0 ; i-- ))
#do
#    case "${mp[mountpoint,$i]}" in
#	"swap" )
#	    sudo swapoff ${main_device}$i
#	    ;;
#	* ) 
#	    sudo umount ${main_device}$i
#	    ;;
#    esac
#    
#done
