#!/bin/bash

#docker run -d haproxy-datadog -v

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker rm -fv haproxy-datadog
docker run -d --name haproxy-datadog \
  -v $DIR/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  -p 3834:3834 \
  -p 3835:3835 \
  haproxy:1.5
# Check if the config file is valid
# docker run -it --rm --name haproxy-syntax-check \
#   haproxy-datadog haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
