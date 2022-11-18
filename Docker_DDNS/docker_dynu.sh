#!/usr/bin/env bash
#-e USERNAME=This is your dynu login username.
#-e PASSWORD=This is your dynu login password.
#-e HOSTNAMES=This are your domains that you want to update.
# wget -qO- https://raw.githubusercontent.com/5points/Docker_tools_Script/main/Docker_DDNS/docker_dynu.sh | sh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/5points/Docker_tools_Script/main/Docker_DDNS/docker_dynu.sh)"

read -p "Enter your Dynu login username: " -e USERNAME
read -p "Enter your Dynu login password: " -e PASSWORD
read -p "Enter your domains that you want to update (separate multiple domains by comma): " -e HOSTNAMES

read -p "Enter the filename for the new script (without extension): " -e FILENAME

DOCKER_COMMAND=$(cat <<'EOF'
docker run -itd \
   --name=dynuddns \
   --privileged=true \
   -e USERNAME=$USERNAME \
   -e PASSWORD=$PASSWORD \
   -e HOSTNAMES=$HOSTNAMES \
   -e REFRESH_TIME=30 \
   -e TZ='Asia/Hong_Kong' \
   --restart unless-stopped \
   --log-opt max-size=10k \
   dokeraj/dynu-updater:latest
EOF
)

echo -e "Docker command to start the container:\n$DOCKER_COMMAND"

# Save to Sh script
echo -e "#!/usr/bin/env sh" > "$FILENAME.sh"
echo -e "$DOCKER_COMMAND" >> "$FILENAME.sh"
chmod +x "$FILENAME.sh"

echo -e "New Docker start script has been saved to $FILENAME.sh"
