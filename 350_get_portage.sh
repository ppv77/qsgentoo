#!/bin/bash
. 000_define.sh
printf "Download portage.\n"

if [ ! ${portage_zip} = "" ] ; then
    pushd ${new_root}/var/db/repos/ >/dev/null
    ${sudo_cmd} wget -nv ${quiet} ${portage_zip}
    ${sudo_cmd} unzip -q gentoo-stable.zip
    ${sudo_cmd} mv  ${verbose} gentoo-stable gentoo
    ${sudo_cmd} rm  ${verbose} gentoo-stable.zip
    popd >/dev/null
fi
