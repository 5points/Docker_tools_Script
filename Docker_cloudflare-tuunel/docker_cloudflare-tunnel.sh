#!/usr/bin/env sh
#!/usr/bin/env bash
#step0-create cloudflard volume: docker volume create cloudflared
#step1-create certificate: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel login
#step2-create tunnel name: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel create <tunnelname>
#step3-add tunnel route dns: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel --config /root/.cloudflared/config.yml route dns <tunnelname> <tunnel-hostname>
DOCKER_NAME=""
CONFIG_NAME=""
TUNNEL_NAME=""

docker run -itd \
   --name ${DOCKER_NAME} \
   --restart unless-stopped \
   --privileged=true \
   --user $(id -u) \
   --net host \
   -v cloudflared:/root/.cloudflared \
   cloudflare/cloudflared \
   tunnel --config /root/.cloudflared/${CONFIG_NAME} run ${TUNNEL_NAME}
