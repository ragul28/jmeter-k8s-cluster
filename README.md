# Jmeter Cluster Support for Kubernetes

## Prerequisits

Kubernetes > 1.8
N.B.: this implementation was tested on Kubernetes version 1.12

## Changelog 
- Edited namespace as default
- Added grafana-reporter as a sidecar container in grafana's k8s deployment
- Grafana datasource (influxdb) & dashboard provisioning automated
- Added LB support to grafana service
- dashboard script automated & removed


## TL;DR

```bash
./dockerimages.sh
./jmeter_cluster_create.sh
./start_test.sh
```

Grafana-reporter - https://github.com/IzakMarais/reporter

## Reference  
- "Load Testing Jmeter On Kubernetes" medium blog post: https://goo.gl/mkoX9E
- Original Github repo: https://github.com/kubernauts/jmeter-kubernetes
