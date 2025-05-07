#!/usr/bin/env sh
#!/usr/bin/env bash
#step0-Create tailscaled volume: docker volume create tailscale
#step1-Login your tailscale account: docker exec tailscaled tailscale login
#*if want login with the authkey(reate the authkey into talscale dashboard): tailscale up --authkey tskey-abcdef1432341818
#step2-enable exit node: tailscale up --accept-dns=false --advertise-exit-node or tailscale up --accept-dns=false
#exit node guide: https://tailscale.com/kb/1103/exit-nodes?tab=linux

CONTAINER_NAME="tailscaled"
VOLUME_NAME="tailscale"

echo "Check if the volume is enabled"
if ! docker volume inspect "$VOLUME_NAME" >/dev/null 2>&1; then
  echo "Creating volume $VOLUME_NAME..."
  docker volume create "$VOLUME_NAME"
  echo "$VOLUME_NAME volume create complete"
fi

docker run -itd \
  --name="$CONTAINER_NAME" \
  --restart unless-stopped \
  --log-opt max-size=1m \
  -v "$VOLUME_NAME":/var/lib \
  -e TS_STATE_DIR=/var/lib/tailscale \
  --network=host \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  --device=/dev/net/tun \
  tailscale/tailscale \
  tailscaled

echo "Container $CONTAINER_NAME started successfully!"
