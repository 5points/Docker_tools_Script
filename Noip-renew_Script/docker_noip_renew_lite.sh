#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
# If you want to use for cron.
# Create this Script and Add a task to cron like this:
# 50 23 * * 1,3,5,7 bash ~/docker_noip_renew_simple.sh >> ~/noip-renew_status.log 2>&1
#
EMAIL="YourAccount"
PASSWD="YourPassword"

docker run --rm -i \
    simaofsilva/noip-renewer \
    $EMAIL \
    $PASSWD
date
