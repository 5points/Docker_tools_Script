#!/usr/bin/env sh
#!/usr/bin/env bash
#step0-create cloudflard volume: docker volume create cloudflared
#step1-create certificate: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel login
#step2-create tunnel name: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel create <tunnelname>
#step4-create tunnel config: wget -O $(docker volume inspect cloudflared | grep Mountpoint | awk '{print $NF}' | sed 's/[",]//g' | awk '{print $0 "/config.yml"}') https://github.com/5points/Docker_tools_Script/raw/main/Docker_cloudflare-tuunel/cloudflare-tunnel-config.yml
#step4-edit tunnel config: vim $(docker volume inspect cloudflared | grep Mountpoint | awk '{print $NF}' | sed 's/[",]//g' | awk '{print $0 "/config.yml"}')
#step5-add tunnel route dns: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel --config /root/.cloudflared/config.yml route dns <tunnelname> <tunnel-hostname>
DOCKER_NAME=""
CONFIG_NAME=""
TUNNEL_NAME=""

docker run -itd \
   --name ${DOCKER_NAME} \
   --restart unless-stopped \
   --log-opt max-size=10k \
   --privileged=true \
   --user $(id -u) \
   --net host \
   -v cloudflared:/root/.cloudflared \
   cloudflare/cloudflared \
   tunnel --config /root/.cloudflared/${CONFIG_NAME} run ${TUNNEL_NAME}
