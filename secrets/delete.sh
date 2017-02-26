#!/usr/bin/env bash

kubectl delete secret pulp-config
kubectl delete secret httpd-cert
kubectl delete secret mongodb-cert
kubectl delete secret client-cert
kubectl delete secret auth-ca
kubectl delete secret qpiddb
kubectl delete configmap pulp-ca
