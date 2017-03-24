#!/bin/bash
. 000_define.sh
pushd ${new_root}/usr/
sudo wget https://github.com/gentoo-mirror/gentoo/archive/stable.zip
sudo unzip -q stable.zip
sudo mv gentoo-stable portage
popd
#sudo git clone ${portage_uri} ${new_root}/usr/portage
