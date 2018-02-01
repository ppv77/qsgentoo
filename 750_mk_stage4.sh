#!/bin/bash 
. 000_define.sh


#${sudo_cmd} cp  ${verbose} 000_define.sh ${new_root}/root
if [ $mk_stage4 = 1 ]; then
    printf "Make Stage4.\n"
    ${sudo_cmd} tar  ${verbose} -cjf ${new_root}/tmp/stage4-amd64-$(date +%m%d%H%M).tar.bz2 --xattrs -X exclude.txt -C ${new_root}/ ./ 
    ${sudo_cmd} mv  ${verbose} ${new_root}/tmp/stage4-amd64-* ${new_root}/
fi