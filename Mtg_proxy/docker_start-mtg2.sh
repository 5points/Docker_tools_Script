#!/bin/bash
# #Generate secret
# If you already have a secret in Base64 format or that, which starts with ee, you can skip this chapter. Otherwise:
# docker run --rm nineseconds/mtg:2 generate-secret --hex bing.com
# #Prepare a configuration file (mtg.toml)
# secret = "ee473ce5d4958eb5f968c87680a23854a0676f6f676c652e636f6d"
# bind-to = "0.0.0.0:443"
MTG_PORT="443:443"

docker run -d \
  --name mtg \
  -v /etc/mtgproxy/mtg.toml:/config.toml 
  -p ${MTG_PORT} \
  --restart=unless-stopped \
  nineseconds/mtg:2
