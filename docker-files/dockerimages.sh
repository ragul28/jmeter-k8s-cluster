#!/bin/bash -e

docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-bash:latest" -f Dockerfile-base .
docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-master:latest" -f Dockerfile-master .
docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-slave:latest" -f Dockerfile-slave .
docker build --tag="ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-reporter" -f Dockerfile-reporter .
