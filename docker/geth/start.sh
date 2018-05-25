#!/bin/sh

OPTS=""
OPTS="$OPTS --datadir /data"
OPTS="$OPTS --rpc --rpcaddr 0.0.0.0"
OPTS="$OPTS --max-peers 100"
OPTS="$OPTS --fast"

echo "-------------------------------------------------------"
echo "Options: $OPTS"
echo "-------------------------------------------------------"
/opt/geth/geth-${VERSION} version
echo "-------------------------------------------------------"

/opt/geth/geth-${VERSION} $OPTS