# options #
#  wget https://raw.githubusercontent.com/5points/Docker_tools_Script/main/Docker_DDNS/Noip-DUC/romeupalos/restart_noip.sh -O /opt/ddns_script/noip_ddns/restart_noip.sh
# Add a work for crontab
# e.g: 
# 56 4 * * 6 bash /opt/ddns_script/noip_ddns/restart_noip.sh

docker rm -v -f noip && \
bash /opt/ddns_script/noip_ddns/docker_noip.sh
