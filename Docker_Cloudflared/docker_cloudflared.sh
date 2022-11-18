docker run -d \
  --name=cloudflared \
  --net=host \
  --restart=always \
  -e PORT=53 \
  -e UPSTREAM1=https://dns.google/dns-query \
  -e UPSTREAM2=https://1.1.1.1/dns-query \
  visibilityspots/cloudflared:latest
