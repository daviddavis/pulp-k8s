#!/usr/bin/env bash

# stops Pulp services

kubectl delete -f resources/httpd.yaml
kubectl delete -f resources/worker.yaml
kubectl delete -f resources/resource_manager.yaml
sleep 1 # let celerybeat notice that the workers are gone and clean up
kubectl delete -f resources/celerybeat.yaml
