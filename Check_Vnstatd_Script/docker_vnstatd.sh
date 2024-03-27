#!/usr/bin/env bash

# 自定义容器名称
CONTAINER_NAME="vnstatd"
# 自定义卷名称
VOLUME_NAME="vnstat_data"

echo "Check if the volume is enabled"
if ! docker volume inspect "$VOLUME_NAME" >/dev/null 2>&1; then
  echo "Creating volume $VOLUME_NAME..."
  docker volume create "$VOLUME_NAME"
fi

docker run -d \
  --name "$CONTAINER_NAME" \
  --net=host \
  --restart=unless-stopped \
  --privileged=true \
  -v /etc/localtime:/etc/localtime \
  -v "$VOLUME_NAME":/var/lib/vnstat \
  carlosedp/vnstat

echo "Container $CONTAINER_NAME started successfully!"
