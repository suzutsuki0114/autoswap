#!/bin/sh

cd "$(dirname "$0")"

# rootかの確認
if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

echo "Stopping autoswap service..."
systemctl stop autoswap.service

echo "Disabling autoswap service..."
systemctl disable autoswap.service

echo "Removing autoswap binary file..."
rm /usr/local/bin/autoswap

echo "Removing autoswap configuration file..."
rm /usr/local/etc/autoswap.conf

echo "Removing autoswap systemd service file..."
rm /etc/systemd/system/autoswap.service
systemctl daemon-reload

if [ -e /usr/local/share/autoswap ]; then
    echo "Removing autoswap swap files..."
    rm -rf /usr/local/share/autoswap
fi
