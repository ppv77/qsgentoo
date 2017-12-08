#!/bin/bash 
. 000_define.sh

printf "Runing chroot task.\n"

${sudo_cmd} chroot ${new_root} /in_chroot_task.sh


