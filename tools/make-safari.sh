#!/bin/bash
#
# This script assumes a linux environment

source ./config

echo "*** scrummer.safari: Copying files"

DES=dist/build/scrummer.safariextension
rm -rf $DES
mkdir -p $DES

cp -R src/*                             $DES/
cp    platform/safari/Info.plist        $DES/

# Replace version
sed -i.bak 's/SCRUMMER_VERSION/'$SCRUMMER_VERSION'/g' $DES/Info.plist
sed -i.bak 's/SCRUMMER_NAME/'$SCRUMMER_NAME'/g' $DES/Info.plist
rm $DES/Info.plist.bak

if [ "$1" = all ]; then
    echo "*** scrummer.safari: Creating package..."
    pushd $(dirname $DES/)
    xarjs create scrummer.safariextz --cert ./../../platform/safari/cert.pem --cert ./../../platform/safari/apple-intermediate.pem --cert ./../../platform/safari/apple-root.pem --private-key ./../../platform/safari/privatekey.pem $(basename $DES/)
fi

echo "*** scrummer.safari: Package done."
