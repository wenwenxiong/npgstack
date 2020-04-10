#!/bin/bash
# Stop and disable the netdata service
service netdata stop
chkconfig netdata off

# Stop node_exporter service
NODE_EXPORTERPID=`ps -elf | grep node_exporter | grep -v grep | awk '{print $4}'`
kill -9 $NODE_EXPORTERPID

# Clean up the folder
rm -rf /opt/netdata && rm -rf /etc/logrotate.d/netdata && rm -rf /etc/rc.d/init.d/netdata
rm -rf /usr/local/bin/node_exporter
