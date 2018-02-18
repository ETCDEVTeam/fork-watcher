#!/bin/sh

IP=$(wget -qO- ipinfo.io/ip)

OPTS=""
OPTS="$OPTS --datadir /data --chain classic"
OPTS="$OPTS --jsonrpc-port 8545 --jsonrpc-interface 0.0.0.0 --jsonrpc-hosts all"
OPTS="$OPTS --warp"
OPTS="$OPTS --no-dapps --no-ipc --no-periodic-snapshot"
OPTS="$OPTS --min-peers 50 --max-peers 100"
#OPTS="$OPTS --nat extip:$IP"

echo "-------------------------------------------------------"
echo "Options: $OPTS"
echo "-------------------------------------------------------"

/opt/parity/parity-${VERSION} $OPTS