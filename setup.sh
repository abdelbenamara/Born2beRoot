#!/bin/bash

main () {
	apt update
	apt install python3 -y
	apt install python3-pip -y
	pip install --upgrade pip setuptools wheel
	pip install ansible-core
	wget https://raw.githubusercontent.com/abdelbenamara/Born2beRoot/main/born2beroot-debian-setup.yml
	ansible-playbook born2beroot-debian-setup.yml
}

main

exit $?
