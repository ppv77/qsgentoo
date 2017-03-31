#!/bin/bash
. 000_define.sh
pushd ${new_root}/usr/
${sudo_cmd} wget ${portage_zip}
${sudo_cmd} unzip -q stable.zip
${sudo_cmd} mv gentoo-stable portage
popd
#${sudo_cmd} git clone ${portage_uri} ${new_root}/usr/portage
