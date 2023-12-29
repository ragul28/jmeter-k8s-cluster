#!/usr/bin/env bash

working_dir=`pwd`

#Get namesapce variable
tenant=`awk '{print $NF}' $working_dir/tenant_export`

echo "Creating Influxdb and the service"
kubectl create -n $tenant -f $working_dir/grafana-dashboard/jmeter_influxdb_configmap.yaml
kubectl create -n $tenant -f $working_dir/grafana-dashboard/jmeter_influxdb_deploy.yaml
kubectl create -n $tenant -f $working_dir/grafana-dashboard/jmeter_influxdb_svc.yaml

echo "Creating Grafana Deployment"
kubectl create configmap datasource-config -n $tenant --from-file=$working_dir/grafana-dashboard/dashboard_files/datasources.yaml
kubectl create configmap dashboard-config -n $tenant --from-file=$working_dir/grafana-dashboard/dashboard_files/dashboards.yaml
kubectl create configmap dashboard-json -n $tenant --from-file=$working_dir/grafana-dashboard/dashboard_files/jmeter-metric.json

kubectl create -n $tenant -f $working_dir/grafana-dashboard/jmeter_grafana_deploy.yaml
kubectl create -n $tenant -f $working_dir/grafana-dashboard/jmeter_grafana_svc.yaml

## Create jmeter database automatically in Influxdb
echo "Creating Influxdb jmeter Database"

##Wait until Influxdb Deployment is up and running
influxdb_status=`kubectl get po -n $tenant | grep influxdb-jmeter | awk '{print $2}' | grep Running

influxdb_pod=`kubectl get po -n $tenant | grep influxdb-jmeter | awk '{print $1}'`
kubectl exec -ti -n $tenant $influxdb_pod -- influx -execute 'CREATE DATABASE jmeter'

## Create the influxdb datasource in Grafana
# echo "Creating the Influxdb data source"
# grafana_pod=`kubectl get po -n $tenant | grep jmeter-grafana | awk '{print $1}'`

## Make load test script in Jmeter master pod executable
# kubectl exec -ti -n $tenant $grafana_pod -c grafana -- curl 'http://admin:admin@127.0.0.1:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary \
# '{"name":"jmeterdb","type":"influxdb","url":"http://jmeter-influxdb:8086","access":"proxy","isDefault":true,"database":"jmeter","user":"admin","password":"admin"}'
