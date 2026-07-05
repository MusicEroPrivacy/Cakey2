#!/usr/bin/env bash
set -e

source /opt/app/config.txt

Xvfb :0 -screen 0 1280x720x24 &
export DISPLAY=:0
fluxbox &

# Automated download of latest Cake Wallet Linux binary from GitHub Releases
if [ ! -f "/opt/app/$APP_BINARY" ]; then
    echo "Cake Wallet binary not found. Programmatically downloading latest release from GitHub..."
    mkdir -p /tmp/cake
    DOWNLOAD_URL=$(curl -s https://api.github.com/repos/cake-tech/cake_wallet/releases/latest | grep "browser_download_url" | grep -i "linux" | head -n 1 | cut -d '"' -f 4)
    if [ -z "$DOWNLOAD_URL" ]; then
        DOWNLOAD_URL="https://github.com/cake-tech/cake_wallet/releases/download/v6.2.0/Cake_Wallet_v6.2.0_Linux.tar.xz"
    fi
    echo "Downloading from: $DOWNLOAD_URL"
    wget -qO /tmp/cake/cake.tar.xz "$DOWNLOAD_URL"
    tar -xf /tmp/cake/cake.tar.xz -C /tmp/cake/
    find /tmp/cake/ -type f -name "Cake_Wallet" -exec cp {} /opt/app/cake_wallet ;
    rm -rf /tmp/cake
fi

if [ -f "/opt/app/$APP_BINARY" ]; then
    chmod +x "/opt/app/$APP_BINARY"
    "/opt/app/$APP_BINARY" &
else
    echo "CRITICAL ERROR: Cake Wallet binary could not be downloaded."
fi

/usr/local/bin/novnc.sh