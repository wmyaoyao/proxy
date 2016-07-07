#!/bin/bash

PORT=5566
# Setup your password first, e.g., PASS=1234
PASS=

if [ "$PASS" == "" ]; then
  echo "# Did you forgot to setup the password first?"
  exit 0
fi

docker rm -f shadowsocks
docker run -d --name shadowsocks -p $PORT:$PORT \
  oddrationale/docker-shadowsocks \
  -s 0.0.0.0 -p $PORT \
  -k $PASS -m aes-256-cfb
