FROM ghcr.io/ragul28/jmeter-k8s-cluster/jmeter-bash:latest
MAINTAINER ragul28
		
EXPOSE 1099 50000
		
ENTRYPOINT $JMETER_HOME/bin/jmeter-server \
-Dserver.rmi.localport=50000 \
-Dserver_port=1099 \
-Jserver.rmi.ssl.disable=true
