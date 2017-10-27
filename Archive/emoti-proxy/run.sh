#!/bin/bash

#docker run -d haproxy-datadog -v

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker rm -fv haproxy-emoti
docker run -d --name haproxy-emoti \
  -v $DIR/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  -p 9527:9527 \
  -p 11180:11180 \
  -p 11181:11181 \
  haproxy:1.6-alpine

# Check if the config file is valid
# docker run -it --rm --name haproxy-syntax-check \
#   haproxy-datadog haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
