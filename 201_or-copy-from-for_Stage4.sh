#!/bin/bash
. 000_define.sh
pushd ${new_root}
${sudo_cmd} rm -i ${Stage3_file}
[ -f ${Stage3_file} ] && exit
${sudo_cmd} cp /home/guest/for_stage4/${Stage3_file} ${new_root}
popd