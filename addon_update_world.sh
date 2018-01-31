#!/bin/bash 
. 000_define.sh

eix-sync
emerge ${verbose} -uND --with-bdeps=y --keep-going @world
dispatch-conf
emerge ${verbose} @preserved-rebuild
dispatch-conf
emerge ${verbose} --depclean
