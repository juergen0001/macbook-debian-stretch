#!/bin/bash

#visudo: %user ALL = NOPASSWD: /usr/local/sbin/vgaswitch.sh



TOSWITCH=$1



switch_to_integrated () {
	echo DIGD > /sys/kernel/debug/vgaswitcheroo/switch 
	/usr/local/sbin/gpu-switch -i
}

switch_to_nvidia () {
	echo DDIS > /sys/kernel/debug/vgaswitcheroo/switch 
	/usr/local/sbin/gpu-switch -d
}

power_off_unused () {
	echo OFF > /sys/kernel/debug/vgaswitcheroo/switch
}
power_on_all () {
	echo ON  > /sys/kernel/debug/vgaswitcheroo/switch
}


case $TOSWITCH in
	"-o" )
		power_on_all
	;;
	"-i" )
		switch_to_integrated
		power_off_unused
	;;
	"-d" )
		switch_to_nvidia
		power_off_unused
	;;
	* )
	echo "usage: $0 [-i|-d]"
	exit 1
	;;
esac

exit 0
