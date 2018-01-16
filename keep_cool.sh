#!/bin/bash

#jz180106 


[ "$(virt-what)" = "" ] || exit 0


#trap 'break' 2 15

for sig in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
	trap 'sig_handler $sig' $sig
done
loop=1



sig_handler () {
	local _sig=$1
	logger -s "got signal $_sig"
[ "15" == "$_sig" ] && loop=0

}

logger -s "switch to integrated graphics and power off nvidia..."
#umschalten auf integrierte Grafik und ausschalten der dedizierten
sudo /usr/local/sbin/vgaswitch.sh -i

#schleife wird durch SIGINT oder SIGTERM verlassen!
while true; do 
sudo /usr/local/sbin/vgaswitch.sh -i
sleep 1
[ $loop -eq 1 ] || break 
done

#alles wieder einschalten
logger -s "power everything on again..."
sudo /usr/local/sbin/vgaswitch.sh -o
