#!/usr/bin/env bash
## wget -O tailscaled-upnp-watchdog.sh https://github.com/5points/Docker_tools_Script/raw/main/Docker_Tailscale/tailscaled-upnp-watchdog.sh && chmod a+x tailscaled-upnp-watchdog.sh
## echo "0 * * * * /yourpath/tailscaled-upnp-watchdog.sh" | crontab -

# Get the directory where the script is running
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Log file located in the same directory as the script
LOG_FILE="$SCRIPT_DIR/tailscaled_upnp_monitor.log"

# Docker container name
DOCKER_CONTAINER_NAME="tailscaled"

# Get the local IPv4 address
local_ip=$(ip addr show eth0 | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)

# Function to log messages
write_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Function to check UPnP port mappings
check_upnp() {
    write_log "Checking UPnP port mappings..."
    mappings=$(upnpc -l | grep "UDP" | grep "$local_ip" | awk '{if ($0 ~ "->" && $0 ~ "UDP") print $0}')

    if [ -z "$mappings" ]; then
        write_log "No UPnP port mappings found for $local_ip. Restarting Docker container $DOCKER_CONTAINER_NAME."
        docker restart $DOCKER_CONTAINER_NAME
        if [ $? -eq 0 ]; then
            write_log "Successfully restarted Docker container: $DOCKER_CONTAINER_NAME."
        else
            write_log "Failed to restart Docker container: $DOCKER_CONTAINER_NAME."
        fi
    else
        write_log "Active UPnP port mapping found for $local_ip: $mappings"
    fi
}

# Main function
main() {
    check_upnp
}

# Script entry point
main
