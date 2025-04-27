# create a docker images list:"touch /~/.docker-tower.list"
# -s, --schedule string                             the cron expression which defines when to update
# -i, --interval int                                poll interval (in seconds) (default 300)
docker run -d \
    --name watchtower \
    --restart unless-stopped \
    --log-opt max-size=10k \
    -v /etc/localtime:/etc/localtime \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower -c \
    --schedule "0 0 6 * * *" \
    $(cat ~/.docker-tower.list)
