#!/bin/bash
. 000_define.sh

printf "Extract Stage.\n"

pushd ${new_root} >/dev/null
#pv $(ls ${Stage3_file}) | ${sudo_cmd} tar xjpf - --xattrs --numeric-owner -C ${new_root}
${sudo_cmd} tar xjpf ${Stage3_file} --xattrs --numeric-owner -C ${new_root}
${sudo_cmd} rm ${Stage3_file}
popd >/dev/null