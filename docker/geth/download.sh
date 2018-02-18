#!/bin/bash

set -e

VERSION=$1

echo "-------------------------------------------------------------------------"
echo "Download Geth $VERSION"
echo " "
echo "-------------------------------------------------------------------------"


FNAME=geth-classic-linux-v${VERSION}.tar.gz
if [ "$VERSION" = "3.5.86" ]; then
    FNAME=geth-classic-linux-v3.5.0.86-db60074.tar.gz
fi

mkdir -p /opt/geth
wget --progress=dot:mega https://github.com/ethereumproject/go-ethereum/releases/download/v${VERSION}/$FNAME
tar -zxf $FNAME
mv geth /opt/geth/geth-$VERSION
rm $FNAME