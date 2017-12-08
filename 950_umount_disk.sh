#!/bin/bash
. 000_define.sh

printf "Umount disks.\n"

${sudo_cmd} umount -R ${new_root}

