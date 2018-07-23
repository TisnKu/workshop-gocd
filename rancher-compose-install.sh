#!/bin/bash

VERSION_NUM=$1

curl -O -L https://github.com/rancher/rancher-compose/releases/download/v${VERSION_NUM}/rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz
tar zxf rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz
rm rancher-compose-linux-amd64-v${VERSION_NUM}.tar.gz
mv rancher-compose-v${VERSION_NUM}/rancher-compose /usr/local/bin/rancher-compose
chmod +x /usr/local/bin/rancher-compose
rm -r rancher-compose-v${VERSION_NUM}
