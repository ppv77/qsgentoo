#!/bin/bash
. 000_define.sh

printf "Extract Stage.\n"

pushd ${new_root} >/dev/null
${sudo_cmd} tar ${verbose} -xpf ${Stage3_file} --xattrs --numeric-owner -C ${new_root}
[ $rm_stage3 = 1  ] && ${sudo_cmd} rm ${verbose} ${Stage3_file}
popd >/dev/null