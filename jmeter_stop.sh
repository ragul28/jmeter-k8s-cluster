#!/usr/bin/env bash
#Script writtent to stop a running jmeter master test

set -eo pipefail

working_dir=`pwd`

#Get namesapce variable
tenant=`awk '{print $NF}' $working_dir/tenant_export`

master_pod=`kubectl get po -n $tenant | grep jmeter-master | awk '{print $1}'`
kubectl -n $tenant exec -ti $master_pod -- /jmeter/apache-jmeter/bin/stoptest.sh
