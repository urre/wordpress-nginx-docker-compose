#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    OPENSSL_CNF_PATH=/etc/ssl/openssl.cnf
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    OPENSSL_CNF_PATH=/System/Library/OpenSSL/openssl.cnf
fi

openssl req \
    -newkey rsa:2048 \
    -x509 \
    -nodes \
    -keyout myapp.local.key \
    -new \
    -out myapp.local.crt \
    -subj /CN=myapp.local \
    -reqexts SAN \
    -extensions SAN \
    -config <(cat $OPENSSL_CNF_PATH \
        <(printf '[SAN]\nsubjectAltName=DNS:myapp.local')) \
    -sha256 \
    -days 3650

mkdir -p ../certs

mv *.crt ../certs/
mv *.key ../certs/

echo -e ${GREEN}"Cert created in /cert! ${NC}"
