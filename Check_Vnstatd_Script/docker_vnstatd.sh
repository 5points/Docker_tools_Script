docker volume create vnstat_data
docker run -d \
  --name vnstatd \
  --net=host \
  --restart=unless-stopped \
  --privileged=true \
  -v /etc/localtime:/etc/localtime \
  -v vnstat_data:/var/lib/vnstat \
  carlosedp/vnstatd
