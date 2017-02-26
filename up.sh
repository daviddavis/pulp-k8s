#!/usr/bin/env bash

kubectl create -f httpd.yaml
kubectl create -f celerybeat.yaml
kubectl create -f worker.yaml
kubectl create -f resource_manager.yaml
