#!/bin/bash -e

docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-bash:latest" -f base.Dockerfile .
docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-master:latest" -f master.Dockerfile .
docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-slave:latest" -f slave.Dockerfile .
