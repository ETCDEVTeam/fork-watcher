#!/bin/sh

set -e

EXTERNAL_IP=$(curl ifconfig.co)

OPTS=""
OPTS="$OPTS --datadir /data"
OPTS="$OPTS --rpc --rpcaddr 0.0.0.0"
OPTS="$OPTS --max-peers 100"
OPTS="$OPTS --nat extip:$EXTERNAL_IP"
#OPTS="$OPTS --cache 2048"

if [ "$MODE" = "fast" ]; then
    OPTS="$OPTS --fast"
fi

echo "-------------------------------------------------------"
echo "Options: $OPTS"
echo "-------------------------------------------------------"
/opt/geth/geth-${VERSION} version
echo "-------------------------------------------------------"

/opt/geth/geth-${VERSION} $OPTS