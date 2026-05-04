#!/bin/sh

cd "$(dirname "$0")"

# rootかの確認
if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

echo "Installing autoswap binary file..."
cp ./autoswap /usr/local/bin/autoswap
chmod +x /usr/local/bin/autoswap

echo "Installing autoswap configuration file..."
cp ./autoswap.conf /usr/local/etc/autoswap.conf

echo "Installing autoswap systemd service file..."
cp ./autoswap.service /etc/systemd/system/autoswap.service
systemctl daemon-reload
