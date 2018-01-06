#!/bin/bash

#jz180106 

trap 'break' 2 15

logger -s "$0 switch to integrated graphics and power off nvidia..."
#umschalten auf integrierte Grafik und ausschalten der dedizierten
sudo /usr/local/sbin/vgaswitch.sh -i

#schleife wird durch SIGINT oder SIGTERM verlassen!
while true; do sleep 1; done

#alles wieder einschalten
logger -s "$0 switch everything on again..."
sudo /usr/local/sbin/vgaswitch.sh -o
