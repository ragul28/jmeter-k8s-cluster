# Jmeter Cluster Support for Kubernetes and OpenShift

## Prerequisits

Kubernetes > 1.8
N.B.: this implementation was tested on Kubernetes version 1.12

Change log -
- Edited namespace as default
- Added grafana-reporter as a sidecar container in grafana's k8s deployment
- Grafana datasource (inflexdb) & dashboard provisioning automated
- Added LB support to grafana service


## TL;DR

```bash
./dockerimages.sh
./jmeter_cluster_create.sh
./dashboard.sh
./start_test.sh
```

Grafana-reporter - https://github.com/IzakMarais/reporter

## Reference  
- "Load Testing Jmeter On Kubernetes" medium blog post: https://goo.gl/mkoX9E
- Original Github repo: https://github.com/kubernauts/jmeter-kubernetes
