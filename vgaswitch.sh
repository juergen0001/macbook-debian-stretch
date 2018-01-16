#!/bin/bash

#visudo: %user ALL = NOPASSWD: /usr/local/sbin/vgaswitch.sh

PROC_ENTRY=/sys/kernel/debug/vgaswitcheroo/switch 

TOSWITCH=$1



switch_to_integrated () {
	[ -f $PROC_ENTRY ] && echo DIGD > $PROC_ENTRY
	/usr/local/sbin/gpu-switch -i
}

switch_to_nvidia () {
	[ -f $PROC_ENTRY ] && echo DDIS > $PROC_ENTRY
	/usr/local/sbin/gpu-switch -d
}

power_off_unused () {
	[ -f $PROC_ENTRY ] && echo OFF > $PROC_ENTRY
}
power_on_all () {
	[ -f $PROC_ENTRY ] && echo ON > $PROC_ENTRY
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
