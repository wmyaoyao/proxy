#!/bin/bash

#docker run -d haproxy-datadog -v
echo "# Launching a haproxy fwd to some ss gateway"
echo "# Note that the port is 5580"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker rm -fv haproxy-ss-fwd
docker run -d --name haproxy-ss-fwd \
  -v $DIR/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  -p 5580:5580 \
  haproxy:1.6-alpine
