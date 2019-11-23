#!/bin/bash

if [ ! -e /tank/time_machine/$1 ]; then
	mkdir /tank/time_machine/$1
	chown $1:"time_machine" /tank/time_machine/$1
    chmod -R 700 $1 /tank/time_machine/$1
fi
exit 0
