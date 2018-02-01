#!/bin/bash
. 000_define.sh

printf "Download portage.\n"

if [ ! ${portage_zip} = "" ] ; then
#    ${sudo_cmd} mkdir ${verbose} -p ${new_root}/usr/portage/gentoo
    pushd ${new_root}/usr/ >/dev/null
    ${sudo_cmd} wget -nv ${quiet} ${portage_zip}
    ${sudo_cmd} unzip -q gentoo-stable.zip
    ${sudo_cmd} mv  ${verbose} gentoo-stable portage
    ${sudo_cmd} rm  ${verbose} gentoo-stable.zip
    popd >/dev/null
#else
#    ${sudo_cmd} git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git ${new_root}/usr/portage
fi
