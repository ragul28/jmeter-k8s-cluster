#!/usr/bin/env bash
#Create multiple Jmeter namespaces on an existing kuberntes cluster
#Started On January 23, 2018

working_dir=`pwd`

echo "checking if kubectl is present"

if ! hash kubectl 2>/dev/null
then
    echo "'kubectl' was not found in PATH"
    echo "Kindly ensure that you can acces an existing kubernetes cluster via kubectl"
    exit
fi

kubectl version --short

echo "Enter the namespace [default]:"
read tenant

if [[ -z $tenant ]]
then
    tenant=default
fi

echo "Using $tenant namespace has been created"
echo

echo "Creating Jmeter slave nodes"
nodes=`kubectl get no | egrep -v "master|NAME" | wc -l`

echo "Number of worker nodes on this cluster is " $nodes

echo "Enter the number of jmeter-slaves [$nodes]:"
read num_slaves

if [[ -z $num_slaves ]]
then
    num_slaves=$nodes
fi
echo "Creating $num_slaves Jmeter slave replicas and service"
echo

sed -i "s~^\([[:blank:]]*\)replicas:.*$~\1replicas: $num_slaves~" $working_dir/jmeter-cluster/jmeter_slaves_deploy.yaml

kubectl create -n $tenant -f $working_dir/jmeter_slaves_deploy.yaml

kubectl create -n $tenant -f $working_dir/jmeter_slaves_svc.yaml

echo "Creating Jmeter Master"

kubectl create -n $tenant -f $working_dir/jmeter_master_configmap.yaml

kubectl create -n $tenant -f $working_dir/jmeter_master_deploy.yaml


echo "Creating Influxdb and the service"

kubectl create -n $tenant -f $working_dir/jmeter_influxdb_configmap.yaml

kubectl create -n $tenant -f $working_dir/jmeter_influxdb_deploy.yaml

kubectl create -n $tenant -f $working_dir/jmeter_influxdb_svc.yaml

echo "Creating Grafana Deployment"

kubectl create configmap datasource-config -n $tenant --from-file=$working_dir/grafana_dashboard/datasources.yaml
kubectl create configmap dashboard-config -n $tenant --from-file=$working_dir/grafana_dashboard/dashboards.yaml
kubectl create configmap dashboard-json -n $tenant --from-file=$working_dir/grafana_dashboard/jmeterTemplate.json

kubectl create -n $tenant -f $working_dir/jmeter_grafana_deploy.yaml

kubectl create -n $tenant -f $working_dir/jmeter_grafana_svc.yaml

echo "Printout Of the $tenant Objects"

echo

kubectl get -n $tenant all

echo namespace = $tenant > $working_dir/tenant_export
