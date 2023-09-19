#!/usr/bin/env sh
#!/usr/bin/env bash
#!/usr/bin/env zsh
if [[ "$(docker volume ls | grep -o vnstat_data)" = "$(echo vnstat_data)" ]];then 
echo have vnstat_data
else
echo not have vnstat_data...
echo create vnstat_data
docker volume create vnstat_data
echo vnstat_data create completed
fi

if [ $? -ne 0 ] && [[ "$(docker volume ls | grep -o vnstat_data)" = "$(echo vnstat_data)" ]];then
docker run -d \
  --name vnstatd \
  --net=host \
  --restart=unless-stopped \
  --privileged=true \
  -v /etc/localtime:/etc/localtime \
  -v vnstat_data:/var/lib/vnstat \
  carlosedp/vnstatd
else
echo have a something wrong
exit 0
fi
