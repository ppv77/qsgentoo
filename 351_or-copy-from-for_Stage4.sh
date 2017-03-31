#!/bin/bash
. 000_define.sh
pushd ${new_root}/usr/
[ ! -f "${new_root}/usr/stable.zip" ] && ${sudo_cmd} cp /var/www/localhost/for_stage4/stable.zip ${new_root}/usr/
${sudo_cmd} unzip -q stable.zip
${sudo_cmd} mv gentoo-stable portage
popd
