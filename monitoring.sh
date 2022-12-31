#!/bin/bash

message () {
	echo "#Architecture: $(uname -a)"
	echo "#CPU physical : $(grep 'physical id' /proc/cpuinfo | sort | uniq | wc -l)"
	echo "#vCPU : $(grep '^processor' /proc/cpuinfo | wc -l)"
	free -m --si | grep 'Mem' | awk '{ printf("#Memory Usage: %d/%dMB (%.2f%%)\n", $7, $2, $7/$2*100) }'
}

message
