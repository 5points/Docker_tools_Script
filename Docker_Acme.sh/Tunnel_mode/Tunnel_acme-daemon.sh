#!/usr/bin/env bash
# Must be used in conjunction with another script "tunnel_in-acme.sh "
CERT_PATH="/etc/path/cert"

docker run -itd \
   --name acme.sh \
   --net host \
   --restart always \
   -v acme.sh:/acme.sh \
   -v ${CERT_PATH}:/etc/cert \
   neilpang/acme.sh \
   daemon
