#!/bin/zsh
#!/bin/bash
#!/bin/sh
SSL_SERVICE="zerossl"
CREATE_MODE="--dns" #example:--standalone --alpn
DNS_MODE="dns_cf" #api mode:'--dns' must be used
DOMAIN_MODE="-d *.domain.com -d domain.com" #ca_update mode:'--ecc' ##ca_apply mode:'-k ec-256'
ECC_MODE="-k ec-256" #if you want create new ca must use '-k ec-256' otherwise change it to '--ecc'
CERT_MODE="--force" #ca_update mode:'--renew --force' #ca_apply mode:'--force'
ECC_PATH="--ecc"
RECMD_PATH="/etc/cert"

acme.sh --issue --server ${SSL_SERVICE} ${CREATE_MODE} ${DNS_MODE} ${DOMAIN_MODE} ${ECC_MODE} --listen-v6 --debug --reloadcmd \
 "acme.sh --installcert ${DOMAIN_MODE} {ECC_PATH} \
          --fullchain-file ${RECMD_PATH}/plugin.crt {ECC_PATH} \
          --key-file ${RECMD_PATH}/plugin.key {ECC_PATH}"
