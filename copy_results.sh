#!/usr/bin/env bash
set -eo pipefail

working_dir=`pwd`

#Get namesapce variable
tenant=`awk '{print $NF}' $working_dir/tenant_export`

# Get Master pod & Copy results
master_pod=$(kubectl get po -n "$tenant" | grep jmeter-master | awk '{print $1}')
kubectl cp -n "$tenant" "$master_pod":/results.tar.gz results.tar.gz