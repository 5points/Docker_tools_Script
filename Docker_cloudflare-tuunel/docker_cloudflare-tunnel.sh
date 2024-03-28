#!/usr/bin/env bash

########################
# Cloudflare Tunnel Installation and Configuration Script
########################

#step0-create cloudflard volume: docker volume create cloudflared
#step1-create certificate: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel login
#step2-create tunnel name: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel create <tunnelname>
#step4-create tunnel config: wget -O $(docker volume inspect cloudflared | grep Mountpoint | awk '{print $NF}' | sed 's/[",]//g' | awk '{print $0 "/config.yml"}') https://github.com/5points/Docker_tools_Script/raw/main/Docker_cloudflare-tuunel/cloudflare-tunnel-config.yml
#step4-edit tunnel config: vim $(docker volume inspect cloudflared | grep Mountpoint | awk '{print $NF}' | sed 's/[",]//g' | awk '{print $0 "/config.yml"}')
#step5-add tunnel route dns: docker run -it --rm --privileged=true --user $(id -u) --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel --config /root/.cloudflared/config.yml route dns <tunnelname> <tunnel-hostname>

# Function to check if a Docker volume exists
check_docker_volume() {
    if docker volume inspect "$1" &>/dev/null; then
        echo "Volume '$1' already exists."
    else
        read -p "Volume '$1' does not exist. Do you want to create it? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker volume create "$1"
        else
            echo "Exiting..."
            exit 1
        fi
    fi
}

# Function to download a file
download_file() {
    local FILE_PATH="$1"
    local URL="$2"
    echo "Downloading file to $FILE_PATH..."
    if command -v curl &>/dev/null; then
        curl -o "$FILE_PATH" -L "$URL"
    elif command -v wget &>/dev/null; then
        wget -O "$FILE_PATH" "$URL"
    else
        echo "Error: Neither curl nor wget is installed. Please install either curl or wget."
        exit 1
    fi
}

# Function to create or overwrite a config file
create_or_overwrite_config_file() {
    local CONFIG_FILE="$1"
    local CONFIG_URL="$2"
    if [ -f "$CONFIG_FILE" ]; then
        read -p "Config file already exists. Do you want to overwrite it? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Exiting..."
            exit 1
        fi
    fi
    download_file "$CONFIG_FILE" "$CONFIG_URL"
}

# Function to create a tunnel
create_tunnel() {
    local TUNNEL_NAME="$1"
    echo "Creating tunnel..."
    docker run -it --rm --privileged=true --user "$(id -u)" --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel create "$TUNNEL_NAME"
}

# Main script

# Check if cloudflared volume exists
check_docker_volume "cloudflared"

# Get Docker volume path
VOLUME_PATH=$(docker volume inspect cloudflared --format '{{ .Mountpoint }}')

# Login to Cloudflare
echo "Logging in to Cloudflare..."
docker run -it --rm --privileged=true --user "$(id -u)" --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel login

# Prompt user for tunnel name
read -p "Enter the name for the tunnel: " -e TUNNEL_NAME

# Create tunnel
create_tunnel "$TUNNEL_NAME"

# Download configuration file
CONFIG_FILE_NAME="cloudflare-tunnel-config"
CONFIG_FILE="${VOLUME_PATH}/${CONFIG_FILE_NAME}.yml"
CONFIG_URL="https://github.com/5points/Docker_tools_Script/raw/main/Docker_cloudflare-tuunel/${CONFIG_FILE_NAME}.yml"
create_or_overwrite_config_file "$CONFIG_FILE" "$CONFIG_URL"

# Update tunnel name in config file
sed -i "s/tunnel: .*/tunnel: '${TUNNEL_NAME}'/" "$CONFIG_FILE"

# Prompt user for tunnel hostname
read -p "Enter the domain name for the tunnel-hostname (e.g., www.abc.xyz): " -e TUNNEL_HOSTNAME

# Update tunnel hostname in config file
sed -i "s/hostname: <tunnel-hostname>/hostname: \"$TUNNEL_HOSTNAME\"/" "$CONFIG_FILE"

# Add tunnel route DNS
echo "Adding tunnel route DNS..."
docker run -it --rm --privileged=true --user "$(id -u)" --net host -v cloudflared:/root/.cloudflared cloudflare/cloudflared tunnel --config "/root/.cloudflared/${CONFIG_FILE_NAME}.yml" route dns "${TUNNEL_NAME}" "${TUNNEL_HOSTNAME}"

# Prompt user for container name
read -p "Enter the name for the Docker container (default: cf-tunnel): " -e DOCKER_NAME
if [ -z "$DOCKER_NAME" ]; then
    DOCKER_NAME="cf-tunnel"
fi
if docker ps -a --format '{{.Names}}' | grep -q "^${DOCKER_NAME}$"; then
    read -p "A container with the name '$DOCKER_NAME' already exists. Do you want to use this name? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Exiting..."
        exit 1
    fi
fi

# Docker run command
DOCKER_RUN_COMMAND=$(cat <<'EOF'
docker run -itd \
   --name ${DOCKER_NAME} \
   --restart unless-stopped \
   --log-opt max-size=10k \
   --privileged=true \
   --user \$(id -u) \
   --net host \
   -v cloudflared:/root/.cloudflared \
   cloudflare/cloudflared \
   tunnel --config /root/.cloudflared/${CONFIG_FILE_NAME}.yml run ${TUNNEL_NAME}
EOF
)

# Output Docker run command
echo "Docker run command:"
echo "$DOCKER_RUN_COMMAND"

# Write Docker run command to script file
echo "$DOCKER_RUN_COMMAND" > run_cloudflared_tunnel.sh

echo "Cloudflare Tunnel container has been successfully started."
