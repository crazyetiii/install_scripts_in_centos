#!/bin/bash

# Usage: ./open_ports.sh <port1> <port2> ...

# Check if sudo is used
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Install firewalld if not installed
if ! rpm -q firewalld &> /dev/null; then
    yum install firewalld -y
fi

# Start and enable firewalld
systemctl start firewalld
systemctl enable firewalld

# Open specified ports
for port in "$@"; do
    firewall-cmd --permanent --add-port=$port/tcp
done

# Reload firewall
firewall-cmd --reload

# Print open ports
echo "Opened ports:"
firewall-cmd --list-ports
