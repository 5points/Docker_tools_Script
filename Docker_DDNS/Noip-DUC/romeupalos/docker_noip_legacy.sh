# # usage # #
# 1.create the file folder to 'opt'
#   mkdir -p /opt/ddns_script/noip_ddns
# 2.download this script to 'ddns_script'
#   wget https://raw.githubusercontent.com/5points/Docker_tools_Script/main/Noip-DUC/romeupalos/docker_noip.sh -O /opt/ddns_script/noip_ddns/docker_noip.sh
# 3.create volume name noip for docker
# 4.create the noip configuration file (if using a root)
#   docker run -it --rm --user $(id -u) -v noip:/usr/local/etc romeupalos/noip -C
# 5.Running:Using a configuration file
# Source:https://github.com/romeupalos/noip
 
docker run -d \
    --name noip \
    --user $(id -u) \
    --restart=always \
    --log-opt max-size=1m \
    -v noip:/usr/local/etc \
    romeupalos/noip -d
