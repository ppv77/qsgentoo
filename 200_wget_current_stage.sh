#!/bin/bash
. 000_define.sh

printf "Download Stage.\n"

pushd ${new_root} >/dev/null
#${sudo_cmd} rm -i ${Stage3_file}
[ -f ${Stage3_file} ] && exit
${sudo_cmd} wget ${quiet} -r -nd --no-parent -A ${Stage3_file}  ${Stage3_uri}
popd >/dev/null
