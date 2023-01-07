#!/bin/bash

main () {
	echo "#Architecture : $(uname -a)"
	echo "#CPU physical : $(grep '^physical id' /proc/cpuinfo | sort -u | wc -l)"
	processors=$(grep -c '^processor' /proc/cpuinfo)
	echo "#vCPU : $processors"
	free -m | grep '^Mem' | awk '{ printf "#Memory Usage : %d/%dMB (%.2f%%)\n", $3, $2, $3 / $2 * 100 }'
	df --total -m | tail -n 1 | awk '{ print "#Disk Usage : " $3 "/" $2 "MB (" $5 ")" }'
	cat /proc/loadavg | awk -v processors="$processors" '{ printf "#CPU load : %.1f%%\n", $1 / processors * 100 }'
	echo "#Last boot : $(who -b | grep -o '....-..-.. ..:..')"
	lsblk | grep 'lvm' | wc -l | awk '{ printf "#LVM use : %s\n", ($1 > 0 ? "yes" : "no") }'
	echo "#Connections TCP : $(ss -t | grep -c '^ESTAB') ESTABLISHED"
	echo "#User log : $(users | wc -w)"
	echo "#Network : IP $(hostname -I | cut -d ' ' -f 1) ($(cat /sys/class/net/$(ip route list | grep default | cut -d ' ' -f 5)/address))"
	echo "#Sudo : $(grep -c sudo /var/log/auth.log) commands"
}

main | wall

exit $?
