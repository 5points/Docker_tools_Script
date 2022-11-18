#!/usr/bin/env bash
CERT_PATH="/etc/path/cert"
SSL_SERVICE="letsencrypt"
CREATE_MODE="--dns" #example:--standalone --alpn
DNS_MODE="dns_cf"
DOMAIN_MODE="-d *.domain.com -d domain.com" #ca_update mode:'--ecc' ##ca_apply mode:'-k ec-256'
CERT_MODE="--force" #ca_update mode:"--renew --force" #ca_apply mode:"--force"
ECC_MODE="-k ec-256" #if you want create new ca must use '-k ec-256' otherwise change it to '--ecc'
ECC_PATH="--ecc"

docker run --rm -itd \
   --name acme.sh \
   --net host \
   -v acme.sh:/acme.sh \
   -v ${CERT_PATH}:/etc/cert \
   neilpang/acme.sh \
   acme.sh --issue --server ${SSL_SERVICE} \
           ${CREATE_MODE} ${DNS_MODE} ${DOMAIN_MODE} ${ECC_MODE} ${CERT_MODE} \
           --reloadcmd \
  "acme.sh --installcert ${DOMAIN_MODE} ${ECC_MODE} \
           --fullchain-file /etc/cert/plugin.crt ${ECC_PATH} \
           --key-file /etc/cert/plugin.key ${ECC_PATH}"
