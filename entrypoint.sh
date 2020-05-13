#!/bin/sh -l

echo "Welcome to the Protocentral nrf52 build system"
echo "---------------------------------"
echo "Release $RELEASE_NAME"
echo "---------------------------------"
make clean
make 

if [ -e _build/wearnrf.hex ]
then
    echo "Relase built"
    echo "---------------------------------"
    echo "Building DFU package"
    nrfutil pkg generate --hw-version 52 --sd-req 0x96 --application-version 0xff --application _build/wearnrf.hex --key-file key_file.pem $RELEASE_NAME.zip
else
    echo "Release failed"
fi