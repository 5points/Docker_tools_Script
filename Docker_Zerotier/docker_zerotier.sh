#!/usr/bin/env sh
#!/usr/bin/env bash
#step0-Create zerotier volume: docker volume create zerotier-one
#step1-Entering the container: docker exec -it zerotier-cli bash
#step2-Join your Zerotier-network: zerotier-cli join <id>

docker run -itd \
  --name zerotier-cli \
  --restart always \
  -v zerotier-one:/var/lib/zerotier-one \
  --net host \
  --cap-add NET_ADMIN \
  --cap-add SYS_ADMIN \
  --device /dev/net/tun \
  zerotier/zerotier
