#!/bin/bash
. 000_define.sh

if [ ! ${portage_zip} = "" ] ; then
    ${sudo_cmd} mkdir -p ${new_root}/usr/portage/gentoo
    pushd ${new_root}/usr/portage/gentoo >/dev/null
    ${sudo_cmd} wget ${quiet} ${portage_zip}
    ${sudo_cmd} tar xjpf portage.tar.bz2 --xattrs --numeric-owner
    ${sudo_cmd} rm portage.tar.bz2
    popd >/dev/null
else
    ${sudo_cmd} git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git ${new_root}/usr/portage/gentoo
fi
