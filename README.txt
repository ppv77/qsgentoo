# qsgentoo
Quick Start Gentoo script

Watch video https://youtu.be/CSY0NWl1Hro

1. boot from gentoo livecd
2. wget https://github.com/ppv77/qsgentoo/archive/v<release>.tar.gz
3. tar xzf v<release>.tar.gz
4. cd qsgentoo-<release>
5. nano 000_define.sh
6. edit and save (By default will be installed system on /dev/sda=40G in one partition)
7. ./0000_run.sh
8. reboot
9. login root:root
10. eix-sync
11. emerge -uND @world
12. feel nice

