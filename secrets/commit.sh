#!/usr/bin/env bash

kubectl create secret generic pulp-config --from-file=server.conf
pushd certs > /dev/null
kubectl create secret generic httpd-cert --from-file=httpd.key --from-file=httpd.crt --from-file=auth-ca.crt --from-file=auth-ca.key
kubectl create secret generic mongodb-cert --from-file=mongodb.pem
kubectl create secret generic client-cert --from-file=client.pem --from-file=client.crt --from-file=client.key
kubectl create secret generic auth-ca --from-file=auth-ca.crt --from-file=auth-ca.key
popd > /dev/null
kubectl create secret generic qpiddb --from-file=qpiddb/nss

kubectl create configmap pulp-ca --from-file=certs/ca.crt
