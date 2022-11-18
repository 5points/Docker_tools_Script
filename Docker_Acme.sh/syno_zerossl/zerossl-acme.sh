#!/bin/sh
DOMAIN_NAME="-d *.domian.com -d domian.com"
PFX_PASSWD="00000008"
CERT_MODE="--force" #ca_update mode:"--renew --force" #ca_apply mode:"--force"
acme.sh --issue --server zerossl --dns dns_cf ${DOMAIN_NAME} ${CERT_MODE} --debug --reloadcmd \
  "acme.sh --installcert ${DOMAIN_NAME} \
          --fullchain-file /opt/cert/fullchain.pem --key-file /opt/cert/privkey.pem --cert-file /opt/cert/cert.pem && \
  acme.sh --installcert ${DOMAIN_NAME}  \
          --fullchain-file /opt/ftpd/fullchain.pem --key-file /opt/ftpd/privkey.pem --cert-file /opt/ftpd/cert.pem && \
  acme.sh --installcert ${DOMAIN_NAME}  \
          --fullchain-file /opt/system/fullchain.pem --key-file /opt/system/privkey.pem --cert-file /opt/system/cert.pem && \
  acme.sh --installcert ${DOMAIN_NAME} \
          --fullchain-file /opt/mycerts/fullchain.crt --key-file /opt/mycerts/privkey.key --cert-file /opt/mycerts/cert.crt && \
  acme.sh --toPkcs ${DOMAIN_NAME} --password ${PFX_PASSWD}"
