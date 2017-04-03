#!/bin/bash
. 000_define.sh

if [ ! ${portage_zip} = "" ] ; then
    pushd ${new_root}/usr/ >/dev/null
    ${sudo_cmd} wget -q ${portage_zip}
    ${sudo_cmd} unzip -q stable.zip
    ${sudo_cmd} mv gentoo-stable portage
    pushd portage >/dev/null
    ${sudo_cmd} git pull
    popd >/dev/null
    ${sudo_cmd} rm stable.zip
    popd >/dev/null
else
    ${sudo_cmd} git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git ${new_root}/usr/portage
fi
