#!/bin/bash
. 000_define.sh

printf "Download portage.\n"

if [ ! ${portage_zip} = "" ] ; then
#    ${sudo_cmd} mkdir ${verbose} -p ${new_root}/usr/portage/gentoo
[ $debug = 1 ] && read -p Enter
    pushd ${new_root}/usr/ >/dev/null
    ${sudo_cmd} wget  ${verbose} ${quiet} ${portage_zip}
    [ $debug = 1 ] && read -p Enter
    ${sudo_cmd} unzip ${quiet} gentoo-stable.zip
    [ $debug = 1 ] && read -p Enter
    ${sudo_cmd} mv  ${verbose} gentoo-stable portage
    [ $debug = 1 ] && read -p Enter
    ${sudo_cmd} rm  ${verbose} gentoo-stable.zip
    [ $debug = 1 ] && read -p Enter
    popd >/dev/null
#else
#    ${sudo_cmd} git clone --depth 1 https://github.com/gentoo-mirror/gentoo.git ${new_root}/usr/portage
fi
