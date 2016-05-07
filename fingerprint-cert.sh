#!/bin/sh
#
# This uses msmtp to check the SHA1 fingerprint of the TLS certificate
# provided by the server.
#

HOST=$1
PORT=$2

if [ $# -gt 0 ]; then

    if [ $# -eq 1 ]; then
        PORT="587"
    fi

    echo "Getting cert fingerprint for ${HOST}:${PORT}"
    msmtp --serverinfo --tls --tls-starttls --tls-certcheck=off --host=$HOST --port=$PORT |\
        grep "SHA1: " |\
        sed 's/.*SHA1: //'

else

    cat << EOF

This script prints the SHA1 fingerprint of the certificate used when
connecting to _host_ on _port_. If port is not provided it defaults
to 587.

--------------------------------------------------------------------

Usage: fingerprint-cert.sh host [port]
    Getting cert fingerprint for host:port
    81:02:7A:3B:BF:94:98:2F:4E:DC:08:F2:F3:34:68:F3:8B:1A:F2:54

EOF

fi
