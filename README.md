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

* Create jmeter-master, slave, influxdb & grafana
    ```bash
    ./jmeter_cluster_create.sh
    ./dashboard.sh
    ```
    *(only if applicable)

* Add Grafana-reporter link to grafana dashboard
    ```url
    http://<Grafana-LB-IP>:8686/api/v5/report/ltaas
    ```

* Start load-test
    ```bash
    ./start_test.sh
    ```


## Reference  
- "Load Testing Jmeter On Kubernetes" medium blog post: https://goo.gl/mkoX9E
- Original Github repo: https://github.com/kubernauts/jmeter-kubernetes
- Grafana-reporter - https://github.com/IzakMarais/reporter
