#!/bin/bash
    
. /opt/rancher/bin/common.sh

AGENCY_LEADER=$(curl -s -H 'Accept: application/json' ${META_URL}/services/arango-agency/containers|jq -r .[0])
AGENCY_LEADER_IP=$(get_container_primary_ip ${AGENCY_LEADER})

STACK_NAME=$(curl -s -H 'Accept: application/json' ${META_URL} | jq -r .self.container.stack_name)

wait_for_agency()
{
    ready=false
    while [ "$ready" != true ]; do
        sleep 5
        ready=true
        timeout 1 bash -c ">/dev/tcp/$AGENCY_LEADER_IP/4000"
        if [ "$?" -ne "0" ]; then
            echo "Agency leader is not ready"
            ready=false
        fi
    done
}

echo "Waiting for all service containers to start..."
giddyup service wait scale --timeout=1200

echo "All containers have started up, waiting for agency to start..."

wait_for_agency
echo "Agency started"
echo "Starting DB servers"

set arangod \
      --cluster.my-role $NODE_TYPE \
      --cluster.my-local-info $(giddyup ip myip) \
      --cluster.agency-endpoint tcp://${AGENCY_LEADER_IP}:4000 \
      --cluster.my-address tcp://$(giddyup ip myip):8529 \
      --server.authentication false \
      --server.endpoint tcp://0.0.0.0:8529 \
      --database.directory /var/lib/arangodb
  
set "$@" $(giddyup ip stringify ${STACK_NAME}/arango-agency --prefix " --agency.endpoint tcp://" --suffix ":4000"  --delimiter "")

echo "$@"
exec "$@"