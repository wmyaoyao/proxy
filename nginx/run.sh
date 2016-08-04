#!/bin/bash

#docker run -d haproxy-datadog -v

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker rm -fv nginx
docker run -d --name nginx \
  -v $DIR/www:/usr/share/nginx/html:ro \
  -v $DIR/ssl:/etc/nginx/ssl:ro \
  -v $DIR/conf/default.conf:/etc/nginx/conf.d/default.conf \
  -p 80:80 \
  -p 443:443 \
  nginx:alpine

#    /etc/nginx/conf.d/default.conf
#  -v $DIR/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
# Check if the config file is valid
# docker run -it --rm --name haproxy-syntax-check \
#   haproxy-datadog haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
