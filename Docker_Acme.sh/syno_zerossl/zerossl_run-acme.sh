#!/usr/bin/env bash
SYNO_CA_PATH=""
ZEROSSL_LOGIN="123@mail.com"

docker run --rm -itd \
  --name acme.sh \
  --net=host \
  -v acme.sh:/acme.sh \
  -v /usr/syno/etc/certificate/_archive/${SYNO_CA_PATH}:/opt/cert \
  -v /usr/syno/etc/certificate/smbftpd/ftpd:/opt/ftpd \
  -v /usr/syno/etc/certificate/system/default:/opt/system \
  -v /volume1/docker/certs:/opt/mycerts \
  neilpang/acme.sh \
  sh -c 'acme.sh --register-account -m ${ZEROSSL_LOGIN} --server zerossl && chmod +x /acme.sh/zerossl-acme.sh && sh /acme.sh/zerossl-acme.sh' && \
  docker logs -f acme.sh > $PWD/acme_status.log &
  sleep 100
  exit
