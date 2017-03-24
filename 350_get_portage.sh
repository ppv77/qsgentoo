#!/bin/bash
. 000_define.sh
pushd ${new_root}/usr/
wget https://github.com/gentoo-mirror/gentoo/archive/stable.zip
unzip stable.zip
mv gentoo-stable portage
popd
#sudo git clone ${portage_uri} ${new_root}/usr/portage
