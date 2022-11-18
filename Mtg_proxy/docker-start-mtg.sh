#!/bin/bash
#!/bin/sh
# if you prefer docker can run this command to generate a secret
#docker run --rm nineseconds/mtg:1 generate-secret tls -c bing.com

YOUT_PORT=""
SECRET=""
docker run -d --restart always --name mtg --ulimit nofile=51200:51200 -p ${YOUR_PORT}:3128 nineseconds/mtg:1 run ${SECRET}
