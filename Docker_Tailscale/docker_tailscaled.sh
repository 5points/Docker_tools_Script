#!/usr/bin/env sh
#!/usr/bin/env bash
#step0-Create tailscaled volume: docker volume create tailscale
#step1-Login your tailscale account: docker exec tailscaled tailscale login
#*if want login with the authkey(reate the authkey into talscale dashboard): tailscale up --authkey tskey-abcdef1432341818
#step2-enable exit node: tailscale up --accept-dns=false --advertise-exit-node or tailscale up --accept-dns=false
#exit node guide: https://tailscale.com/kb/1103/exit-nodes?tab=linux

docker run -itd \
  --name=tailscaled \
  --restart unless-stopped \
  -v tailscale:/var/lib \
  -e TS_STATE_DIR=/var/lib/tailscale \
  --network=host \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  --device=/dev/net/tun \
  tailscale/tailscale \
  tailscaled
