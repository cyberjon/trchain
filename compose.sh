#!/bin/bash
#Install compose 0.19.4
su - hyper <<EOF
echo "" > $(npm config get globalconfig)
npm config --global edit
npm uninstall -g composer-cli
npm install -g composer-cli@0.19.4
EOF
