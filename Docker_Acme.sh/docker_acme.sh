#!/usr/bin/env bash
VOLUME="acme.sh"
DNS_MODE="dns_cf"
SSL_SERVICE="letsencrypt"
CERT_MODE="--force"
DOMAIN_NAME="-d subdomian.com"
# CERT_MODE have more parameter : "--force" "daemon" and more.
# DNS_ISSUE example : dns_cf (cloudflare) readmore:https://github.com/acmesh-official/acme.sh/wiki/dnsapi
# VOLUME recommended use volume mount parameter
# DOMIAN if you want make a more domian must add "space" + "-d" like: DOMIAN="-d subdomian.com -d *.subdomian.com"
#
docker run --rm -itd \
  --name acme.sh \
  --net=host \
  -v $VOLUME:/acme.sh \
  neilpang/acme.sh \
  acme.sh --issue --server ${SSL_SERVICE} --dns ${DNS_MODE} ${DOMAIN_NAME} ${CERT_MODE}
