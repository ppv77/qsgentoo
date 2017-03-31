#!/bin/bash -v
. 000_define.sh

if [ ! ${portage_zip} = "" ] ; then
    pushd ${new_root}/usr/
    ${sudo_cmd} wget -q ${portage_zip}
    ${sudo_cmd} unzip -q stable.zip
    ${sudo_cmd} mv gentoo-stable portage
    pushd portage
    ${sudo_cmd} git pull
    popd
    ${sudo_cmd} rm stable.zip
    popd
else
    ${sudo_cmd} git clone https://github.com/gentoo-mirror/gentoo.git ${new_root}/usr/portage
fi
