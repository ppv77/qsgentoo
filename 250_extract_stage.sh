#!/bin/bash
. 000_define.sh
pushd ${new_root}
pv $(ls ${Stage3_file}) | ${sudo_cmd} tar xjpf - --xattrs --numeric-owner -C ${new_root}
popd
