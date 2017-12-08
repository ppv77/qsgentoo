#!/bin/bash
. 000_define.sh

printf "Download portage.\n"

if [ ! ${portage_zip} = "" ] ; then
#    ${sudo_cmd} mkdir -p ${new_root}/usr/portage/gentoo
    pushd ${new_root}/usr/ >/dev/null
    ${sudo_cmd} wget ${quiet} ${portage_zip}
    ${sudo_cmd} unzip ${quiet} stable.zip
    ${sudo_cmd} mv gentoo-stable portage/gentoo
    ${sudo_cmd} rm stable.zip
    popd >/dev/null
else
    ${sudo_cmd} git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git ${new_root}/usr/portage/gentoo
fi
