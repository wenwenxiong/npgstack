#!/bin/bash
# Stop and disable the netdata service
systemctl stop netdata.service
systemctl disable netdata.service
# Stop and disable nodeexporter.service
systemctl stop nodeexporter.service
systemctl disable nodeexporter.service
# Clean up the folder
rm -rf /opt/local/netdata
rm -rf /opt/local/nodeexporter
# Remove the systemd file
rm -f /etc/systemd/system/netdata.service
rm -f /etc/systemd/system/nodeexporter.service
