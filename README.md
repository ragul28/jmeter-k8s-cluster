# Jmeter Cluster in Kubernetes

## Prerequisits

- Kubernetes Cluster version 1.16+
- Kubectl access

## Setup Guide

* Create jmeter-master, slave, influxdb & grafana
    ```bash
    ./jmeter_cluster_create.sh
    ```

* grafana dashboard (optional)
    ```
    ./grafana-dashboard/dashboard.sh
    ```
* Add Grafana-reporter link to `http://<Grafana-LB-IP>:8686/api/v5/report/ltaas` (optional)

* To Start jmeter load test
    ```bash
    ./start_test.sh <jmx_file_path>
    ```

### Start load-test with csv

* To run the load test
    ```bash
    ./start_csv_copy.sh <jmx_dir>
    ./start_csv_test.sh <jmx_dir>
    ```

* To copy the results file as `tar.gz`
    ```bash
    ./copy_results.sh
    ```

* To stop the load test during the execution
    ```bash
    ./jmetet_stop.sh
    ```

## Changelog 
- Edited namespace as default
- Added grafana-reporter as a sidecar container in grafana's k8s deployment
- Grafana datasource (influxdb) & dashboard provisioning automated
- Added LB support to grafana service
- Move kube manifest separate directory
- Separated csv copy & load test function
- Added support to generate native jmeter report & copy back to local  

## Reference  
- "Load Testing Jmeter On Kubernetes" medium blog post: https://goo.gl/mkoX9E
- Original Github repo: https://github.com/kubernauts/jmeter-kubernetes
- Grafana-reporter - https://github.com/IzakMarais/reporter
