# Jmeter Cluster Support for Kubernetes and OpenShift

## Prerequisits

Kubernetes > 1.8
N.B.: this implementation was tested on Kubernetes version 1.12

Edited to run on default namespace

## TL;DR

```bash
./dockerimages.sh
./jmeter_cluster_create.sh
./dashboard.sh
./start_test.sh
```

import Grafana jmeter dashboard json to grafana

To genarate  the report 
```bash
kubectl apply -f jmeter_grafana_reporter.yaml
```
Grafana-reporter - https://github.com/IzakMarais/reporter

## Reference  
- "Load Testing Jmeter On Kubernetes" medium blog post: https://goo.gl/mkoX9E
- Original Github repo: https://github.com/kubernauts/jmeter-kubernetes
