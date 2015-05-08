#!/bin/bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
    SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
    exit;
fi

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")
cd $SCRIPT_DIR
cd ..
cp $SCRIPT_DIR/Dockerfile .
sudo docker build .

echo ""
echo "Now run the following commands to start the container"
echo "mkdir -p /mnt/mumble ."
echo "sudo docker run -d=true -p=64738:64738 -v=/mnt/mumble:/data [IMAGE ID HERE]"