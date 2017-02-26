#!/usr/bin/env bash

kubectl create secret generic pulp-config --from-file=server.conf
pushd certs
kubectl create secret generic httpd-cert --from-file=httpd.key --from-file=httpd.crt
popd

kubectl create configmap pulp-ca --from-file=certs/ca.crt
