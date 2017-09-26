#!/bin/bash
    
. /opt/rancher/bin/common.sh

peer_wait_hosts()
{
    ready=false
    while [ "$ready" != true ]; do
        sleep 5
        ready=true
        for peer in $(giddyup service containers --exclude-self -n); do
            IP=$(get_container_primary_ip ${peer})
            timeout 1 bash -c ">/dev/tcp/$IP/4000"
            if [ "$?" -ne "0" ]; then
                echo "Agent $peer is not ready"
                ready=false
            fi
        done
    done
}

echo "Waiting for all service containers to start..."
giddyup service wait scale --timeout=1200

echo "All containers have started up, orchestrating..."

giddyup leader check
if [ "$?" -eq "0" ];then
    echo "I'm the leader"
    echo "Waiting for all agent containers to start..."
    peer_wait_hosts
    echo "All Agents started starting leader"
    set arangod \
      --server.authentication false \
      --server.endpoint tcp://0.0.0.0:4000 \
      --database.directory /var/lib/arangodb/$(giddyup ip myip) \
      --agency.id $(get_my_id) \
      --agency.size $(giddyup service scale) \
      --agency.supervision true \
      --agency.notify true
    set "$@" $(giddyup ip stringify --prefix " --agency.endpoint tcp://" --suffix ":4000"  --delimiter "")
    echo "$@"
    exec "$@"
else
    echo "I'm not the leader"
    set arangod \
      --server.authentication false \
      --server.endpoint tcp://0.0.0.0:4000 \
      --database.directory /var/lib/arangodb \
      --agency.id $(get_my_id) \
      --agency.size $(giddyup service scale) \
      --agency.supervision true 
    echo "$@"
    exec "$@"
fi