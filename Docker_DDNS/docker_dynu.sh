#-e USERNAME=This is your dynu login username.
#-e PASSWORD=This is your dynu login password.
#-e HOSTNAMES=This are your domains that you want to update.
docker run -itd \
   --name=dynuddns \
   --privileged=true \
   -e USERNAME= \
   -e PASSWORD=  \
   -e HOSTNAMES=  \
   -e REFRESH_TIME=30 \
   -e TZ="Asia/Hong_Kong" \
   --restart unless-stopped \
   --log-opt max-size=10k \
   dokeraj/dynu-updater:latest
