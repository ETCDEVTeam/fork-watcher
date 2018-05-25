#!/bin/bash

set -e

VERSION=$1
GIT=$2

echo "-------------------------------------------------------------------------"
echo "Download Geth $VERSION"
echo " "
echo "-------------------------------------------------------------------------"

FNAME=geth-classic-linux-v${VERSION}-${GIT}.tar.gz

mkdir -p /opt/geth
wget --progress=dot:mega https://github.com/ethereumproject/go-ethereum/releases/download/v${VERSION}/$FNAME
tar -zxf $FNAME
mv geth /opt/geth/geth-$VERSION
rm $FNAME