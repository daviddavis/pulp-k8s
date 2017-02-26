#!/usr/bin/env bash

kubectl delete secret pulp-config
kubectl delete secret httpd-cert
kubectl delete configmap pulp-ca
