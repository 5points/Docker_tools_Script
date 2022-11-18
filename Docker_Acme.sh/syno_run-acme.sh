#!/usr/bin/env bash
SYNO_CA_PATH=""
DOMAIN_NAME="-d *.domain.com -d domain.com"
CERT_MODE="--force" #ca_update mode:"--renew --force" #ca_apply mode:"--force"

docker run --rm -itd \
  --name acme.sh \
  --net=host \
  -v acme.sh:/acme.sh \
  -v /usr/syno/etc/certificate/_archive/${SYNO_CA_PATH}:/opt/cert \
  -v /usr/syno/etc/certificate/smbftpd/ftpd:/opt/ftpd \
  -v /usr/syno/etc/certificate/system/default:/opt/system \
  neilpang/acme.sh \
  acme.sh --issue --server letsencrypt --dns dns_cf ${DOMAIN_NAME} ${CERT_MODE} --reloadcmd \
  "acme.sh --installcert ${DOMAIN_NAME} \
          --fullchain-file /opt/cert/fullchain.pem --key-file /opt/cert/privkey.pem --cert-file /opt/cert/cert.pem && \
  acme.sh --installcert ${DOMAIN_NAME}  \
          --fullchain-file /opt/ftpd/fullchain.pem --key-file /opt/ftpd/privkey.pem --cert-file /opt/ftpd/cert.pem && \
  acme.sh --installcert ${DOMAIN_NAME}  \
          --fullchain-file /opt/system/fullchain.pem --key-file /opt/system/privkey.pem --cert-file /opt/system/cert.pem" && \
  docker logs -f acme.sh > $PWD/acme_status.log &
  sleep 5
  exit
