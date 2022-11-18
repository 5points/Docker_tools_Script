# create a docker images list:"touch ~/.docker-tower.list"
# -s, --schedule string                             the cron expression which defines when to update
# -i, --interval int                                poll interval (in seconds) (default 300)
docker run --rm \
    --name watchtower \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower -cR \
    $(cat ~/.docker-tower.list)
