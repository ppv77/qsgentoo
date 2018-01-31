#!/bin/bash 
. 000_define.sh

#echo ${new_root} $1
${sudo_cmd} chroot ${new_root} $1
