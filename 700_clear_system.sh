#!/bin/bash 
. 000_define.sh


${sudo_cmd} rm -Rf ${new_root}/usr/portage
${sudo_cmd} rm ${new_root}/usr/stable.zip
${sudo_cmd} rm ${new_root}/stage3*



