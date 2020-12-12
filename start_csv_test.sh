#!/usr/bin/env bash

set -eo pipefail

working_dir=$(pwd)
tenant=default

jmx_dir=$1

if [ ! -d "$jmx_dir" ];
then
    echo "Test script dir was not found & check  the input file path"
    exit
fi

# Get Load testing details
echo "Enter the number of threads:"
read num_threads
sed -i "s~^\([[:blank:]]*\)<stringProp name=\"ThreadGroup.num_threads\">.*$~\1<stringProp name=\"ThreadGroup.num_threads\">$num_threads</stringProp>~" ${jmx_dir}/${jmx_dir}.jmx

# echo "Enter the ramp_time:"
# read ramp_time
# sed -i "s~^\([[:blank:]]*\)<stringProp name=\"ThreadGroup.ramp_time\">.*$~\1<stringProp name=\"ThreadGroup.ramp_time\">$ramp_time</stringProp>~" ${jmx_dir}/${jmx_dir}.jmx

echo "Enter the duration:"
read duration
sed -i "s~^\([[:blank:]]*\)<stringProp name=\"ThreadGroup.duration\">.*$~\1<stringProp name=\"ThreadGroup.duration\">$duration</stringProp>~" ${jmx_dir}/${jmx_dir}.jmx

# Master pod
printf "Copy %s to master\n" "${jmx_dir}.jmx"
master_pod=$(kubectl get po -n "$tenant" | grep jmeter-master | awk '{print $1}')
kubectl cp "${jmx_dir}/${jmx_dir}.jmx" -n "$tenant" "$master_pod":/

# Starting Jmeter load test
kubectl exec -ti -n "$tenant" "$master_pod" -- /jmeter/load_test "/${jmx_dir}.jmx"
# OR to run it on background
# kubectl exec -ti -n "$tenant" "$master_pod" -- bash -c "/jmeter/load_test "/${jmx_dir}.jmx > /dev/null 2> /dev/null &" 

# to check the logs
# kubectl exec jmeter-master-7755b94449-2gpnt -- tail -f jmeter.log

mkdir results 
kubectl cp -n "$tenant" "$master_pod":/results.tar.gz results.tar.gz
