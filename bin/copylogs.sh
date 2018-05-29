#!/bin/sh

set -e

TS=$(date +%y%m%d%H%M%S)
VER=$1
POD=$2
COMMENT="$3"

if [ ! -z "$COMMENT" ]; then
    COMMENT="-$COMMENT"
fi

ARCHIVE=geth-${VER}${COMMENT}.logs.${TS}.tar.gz

echo "Copy logs from pod $2 as Geth $1 to file $ARCHIVE"

kubectl exec $POD -- mkdir logs$TS
kubectl exec $POD -- cp /data/mainnet/log/geth-${VER}.INFO ./logs$TS
kubectl exec $POD -- cp /data/mainnet/log/geth-${VER}.WARNING ./logs$TS
kubectl exec $POD -- cp /data/mainnet/log/geth-${VER}.ERROR ./logs$TS
kubectl exec $POD -- tar -czf $ARCHIVE logs$TS
kubectl cp $POD:/opt/geth/$ARCHIVE ./$ARCHIVE