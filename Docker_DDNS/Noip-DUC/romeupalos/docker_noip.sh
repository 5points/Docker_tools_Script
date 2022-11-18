#!/usr/bin/env bash
# # usage # #
# 1. wget -qO- https://raw.githubusercontent.com/5points/Docker_tools_Script/main/Noip-DUC/romeupalos/docker_noip.sh | sh
# 1.2 sh -c "$(curl -fsSL https://raw.githubusercontent.com/5points/Docker_tools_Script/main/Noip-DUC/romeupalos/docker_noip.sh)"
# 2.create volume name noip for docker
# 3.create the noip configuration file (if using a root)
#   docker run -it --rm --user $(id -u) -v noip:/usr/local/etc romeupalos/noip -C
# 4.Running:Using a configuration file
# Source:https://github.com/romeupalos/noip

echo "Welcome to the interactive setup script for No-IP Docker container."
echo

read -p "Enter the name for the container: " -e CONTAINER_NAME
read -p "Enter the name for the Docker volume: " -e DDNSVOL_NAME
read -p "Enter the filename for the Docker run script (without extension): " -e SCRIPT_FILENAME

if docker volume inspect noip-$DDNSVOL_NAME &>/dev/null; then
    echo "Volume 'noip-$DDNSVOL_NAME' already exists. Please choose another name."
    exit 1
else
    echo "Creating volume 'noip-$DDNSVOL_NAME' for Docker..."
    docker volume create noip-$DDNSVOL_NAME
    if [ $? -ne 0 ]; then
        echo "Error creating volume. Exiting..."
        exit 1
    fi
fi

echo "Creating the No-IP configuration file (if using root)..."
docker run -it --rm --user $(id -u) -v noip-$DDNSVOL_NAME:/usr/local/etc romeupalos/noip -C

echo "Running the Docker container..."
docker run -d \
    --name noip-$CONTAINER_NAME \
    --user $(id -u) \
    --restart=always \
    --log-opt max-size=1m \
    -v noip-$DDNSVOL_NAME:/usr/local/etc \
    romeupalos/noip -d

echo "Setup completed successfully!"

# Generate Docker run script in the current directory
DOCKER_RUN_COMMAND=$(cat <<'EOF'
docker run -d \
    --name noip-$CONTAINER_NAME \
    --user $(id -u) \
    --restart=always \
    --log-opt max-size=1m \
    -v noip-$DDNSVOL_NAME:/usr/local/etc \
    romeupalos/noip -d
EOF
)

echo -e "#!/usr/bin/env sh" > "${SCRIPT_FILENAME}.sh"
echo "$DOCKER_RUN_COMMAND" >> "${SCRIPT_FILENAME}.sh"
chmod +x "${SCRIPT_FILENAME}.sh"

echo "Docker run script has been generated: ${SCRIPT_FILENAME}.sh"
