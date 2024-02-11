# Jmeter Cluster in Kubernetes

## Prerequisits

- Kubernetes Cluster version 1.27+
- Kubectl access

## Setup Guide

* Create jmeter cluster. Script inputs are `namespace` (for default press enter) & `Slave count` (Default count depends on worker nodes).  
    ```bash
    ./jmeter_cluster_create.sh
    ```

* Create grafana, reporter & Influxdb for dashboard (optional)
    ```
    ./dashboard.sh
    ```
* To access the Grafana dashboard use LB url from grafana service. Or use Kube port-forward to access.
    ```bash
    kubectl port-forward svc/jmeter-grafana 3000
    ```
* To generate Grafana-reporter add reporter endpoint `http://<GRAFANA_LB_URL>:8686/api/v5/report/ltaas` as dashboard link. [Visual guide](https://github.com/IzakMarais/reporter/blob/master/demo/report_v5.gif). Or use port-forward both to access.
    ```bash
    kubectl port-forward svc/jmeter-grafana 3000 8686
    ```

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
