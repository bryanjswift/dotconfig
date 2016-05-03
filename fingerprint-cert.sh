#!/bin/sh
#
#for CERT in \
#  imap.gmail.com:993 \
#  smtp.gmail.com:465
#do
#  echo "${CERT}"
#  echo |\
#  openssl s_client -connect $CERT 2>/dev/null |\
#  openssl x509 -noout -fingerprint
#done
#
# See http://www.shellhacks.com/en/HowTo-Check-SSL-Certificate-Expiration-Date-from-the-Linux-Shell

echo "${1}"
echo |\
openssl s_client -connect $1 2>/dev/null |\
openssl x509 -noout -fingerprint
