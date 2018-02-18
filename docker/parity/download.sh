#!/bin/bash

set -e

VERSION=$1

echo "-------------------------------------------------------------------------"
echo "Download Parity $VERSION"
echo " "
echo "-------------------------------------------------------------------------"

FNAME=parity_${VERSION}_amd64.deb

mkdir -p /opt/parity

wget --progress=dot:mega https://parity-downloads-mirror.parity.io/v${VERSION}/x86_64-unknown-linux-gnu/$FNAME
dpkg -i $FNAME
mv /usr/bin/parity /opt/parity/parity-$VERSION
rm $FNAME