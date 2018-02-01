#!/bin/bash 
. 000_define.sh

eix-sync
emerge ${verbose} ${ask} -uND --with-bdeps=y --keep-going @world
dispatch-conf
emerge ${verbose}  ${ask} @preserved-rebuild
dispatch-conf
emerge ${verbose}  ${ask} --depclean
