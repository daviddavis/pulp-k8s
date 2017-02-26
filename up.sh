#!/usr/bin/env bash

kubectl create -f httpd.yaml
kubectl create -f celery.yaml
kubectl create -f worker.yaml
kubectl create -f resource_manager.yaml
