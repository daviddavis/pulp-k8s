#!/usr/bin/env bash

CERTS=certs
ORG=pulp
TMP="$(mktemp -d)"

mkdir -p certs

##### Create self-signed CA

# create CA key
openssl genrsa -out certs/ca.key 4096 #&> /dev/null

# create signing request
openssl req \
  -new \
  -key certs/ca.key \
  -out ${TMP}/ca.req \
  -subj "/CN=pulpca/O=$ORG" #&> /dev/null

# create a self-signed CA certificate
openssl x509 \
  -req \
  -days 7035 \
  -sha256 \
  -extensions ca  \
  -signkey certs/ca.key \
  -in ${TMP}/ca.req \
  -out certs/ca.crt #&> /dev/null


##### Create httpd cert

# create CA key
openssl genrsa -out certs/httpd.key 4096 #&> /dev/null

# create signing request
openssl req \
  -new \
  -key certs/httpd.key \
  -out ${TMP}/httpd.req \
  -subj "/CN=pulpapi/O=$ORG" #&> /dev/null

# create a signed certificate
openssl x509 \
  -req \
  -CA certs/ca.crt \
  -CAkey certs/ca.key \
  -CAcreateserial \
  -in ${TMP}/httpd.req \
  -out certs/httpd.crt #&> /dev/null


# clean
rm ${TMP}/*.req
rmdir ${TMP}
