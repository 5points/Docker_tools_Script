#!/bin/bash
#!/bin/sh
# If you want to use for cron.
# Create this Script and Add a task to cron like this:
# 50 23 * * 1,3,5,7 bash ~/docker_noip_renew_simple.sh >> ~/noip-renew_status.log 2>&1
ACCOUNT=""
PASSWORD=""
docker run --rm -i \
    simaofsilva/noip-renewer \
    ${ACCOUNT} \
    ${PASSWORD}
date
