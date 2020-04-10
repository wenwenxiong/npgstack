#!/bin/bash

#check linux kernel version
KERNEL_VERSION=`uname -r | awk -F- '{print $1}'`
MEET_VERSION=3.10.0

# V1 >= V2
function version_ge()
{
   test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1";
}
# V1 < V2
function version_lt()
{
   test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1";
}

if version_ge $KERNEL_VERSION $MEET_VERSION; then
   echo "$KERNEL_VERSION >= $MEET_VERSION"
   echo "uninstall npg agent with docker ways"
   curl http://{{ hostvars[groups['npg-master'][0]].ip }}:8888/uninstall_monitor_docker.sh|bash
fi

if version_lt $KERNEL_VERSION $MEET_VERSION; then
   echo "$KERNEL_VERSION < $MEET_VERSION"
   echo "uninstall npg agent with binary ways"
   curl http://{{ hostvars[groups['npg-master'][0]].ip }}:8888/uninstall_monitor_binary.sh|bash
fi

