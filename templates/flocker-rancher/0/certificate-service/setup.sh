#!/bin/bash

META_URL="http://rancher-metadata/latest"
CONTROL_SERVICE_IP=$(curl -s -H 'Accept: application/json' ${META_URL}/stacks/flocker/services/control-service/containers/0/primary_ip)

export PATH=$PATH:/opt/flocker/bin/

rm -r /etc/flocker/*
mkdir -p /var/lib/flocker/loopback
cp /app/agent.yml /etc/flocker/agent.yml
echo -e "\n  hostname: ${CONTROL_SERVICE_IP}" >> /etc/flocker/agent.yml
sed -ri 's/^(\s*)(api_id\s*:\s*api_id\s*$)/\1api_id: '${API_ID}'/' /etc/flocker/agent.yml
sed -ri 's/^(\s*)(api_key\s*:\s*api_key\s*$)/\1api_key: '${API_KEY}'/' /etc/flocker/agent.yml

curl -LOk https://s3.ap-south-1.amazonaws.com/adityareddy-rancher/certs/cluster.crt
curl -LOk https://s3.ap-south-1.amazonaws.com/adityareddy-rancher/certs/cluster.key

flocker-ca create-control-certificate $(hostname) 
rename 's/[^.]*/control-service/' control*

flocker-ca create-node-certificate
for OUTPUT in $(ls -Art | tail -n 2)
do
  echo $OUTPUT
	mv $OUTPUT ${OUTPUT/*./node.}
done

flocker-ca create-api-certificate plugin

chmod 0600 /etc/flocker/*