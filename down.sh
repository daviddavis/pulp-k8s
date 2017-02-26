#!/usr/bin/env bash

kubectl delete -f httpd.yaml
kubectl delete -f celerybeat.yaml
kubectl delete -f worker.yaml
kubectl delete -f resource_manager.yaml
