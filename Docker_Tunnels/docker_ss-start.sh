#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
PORT="number:number"
NAME="name"
NET_MODE="bridge"
VOLUME="volume_name_path"
CERT_PATH:"/etc/path/certs/"
IMAGE_VOLUME="image_name"
IMAGE_AUTHOR="author"
#
docker run -d \
   -p $PORT \
   -p $PORT/udp \
   --name $NAME \
   --net $NET_MODE \
   --restart=always \
   --log-opt max-size=1m \
   -v $VOLUME:/etc/$IMAGE_VOLUME \
   -v $CERT_PATH:/etc/certs \
   $IMAGE_AUTHOR/$IMAGE_VOLUME
