#!/bin/bash

PORT=5566
# Setup your password first, e.g., PASS=1234
PASS=foobar

if [ "$PASS" == "" ]; then
  echo "# Did you forgot to setup the password first?"
  exit 0
fi

docker rm -f shadowsocks
#docker run -d --name shadowsocks -p $PORT:$PORT \
#  oddrationale/docker-shadowsocks \
#  -s 0.0.0.0 -p $PORT \
#  -k $PASS -m aes-256-cfb

# Try a smaller image
# https://hub.docker.com/r/dockage/shadowsocks-server
# Port fixed to 8388 (or will need to overwrite expose in dockerfile?)
# See dockerfile in the url above for more info
docker run -d \
    --name shadowsocks \
    -p 8388:8388 \
    -e SS_PASSWORD=$PASS \
    -e SS_METHOD=aes-256-cfb \
  dockage/shadowsocks-server


