#!/bin/bash
. 000_define.sh
pushd ${new_root}
sudo rm -i ${Stage3_file}
[ -f ${Stage3_file} ] && exit
sudo wget -r -nd --no-parent -A ${Stage3_file}  ${Stage3_uri}
popd