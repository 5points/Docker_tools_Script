#!/bin/zsh
#!/bin/bash
#!/bin/sh
DOCKER_IMAGE="chenhw2/dnsproxy" # x86_64:chenhw2/dnsproxy armv7/v8:akadan47/dnsproxy or vmstan/dnsproxy

docker run -d \
  --name=dnsproxy \
  --net=host \
  --restart=always \
  -v dnsproxy:/opt/dnsproxy \
  -e "ARGS= --/opt/dnsproxy/config.yaml" \
      ${DOCKER_IMAGE}
