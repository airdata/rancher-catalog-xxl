#!/bin/bash

# Installing dnsutils and jq
echo "deb http://http.debian.net/debian wheezy-backports main" | tee /etc/apt/sources.list.d/wheezy-backports.list > /dev/null
echo "deb http://security.debian.org/ wheezy/updates main contrib non-free " | tee /etc/apt/sources.list.d/wheezy-security.list > /dev/null
echo "deb-src http://security.debian.org/ wheezy/updates main contrib non-free" | tee /etc/apt/sources.list.d/wheezy-security.list > /dev/null
apt-get -q update > /dev/null
apt-get install -qqy dnsutils jq curl > /dev/null 2>&1
# Add Giddyup
curl -LOk https://github.com/cloudnautique/giddyup/releases/download/v0.14.0/giddyup 
mv giddyup /usr/bin/giddyup
chmod +x /usr/bin/giddyup

mkdir -p /var/lib/arangodb
chown 999 -R /var/lib/arangodb

TCP_TIMEOUT=1
DAEMON_PORT=24007
META_URL="http://rancher-metadata/2015-07-25"

SELF_NAME=$(curl -s -H 'Accept: application/json' ${META_URL}/self/container| jq -r .name)

get_container_primary_ip() {
    IP=$(curl -s -H 'Accept: application/json' ${META_URL}/containers/${1}|jq -r .primary_ip)
    echo ${IP}
}

get_my_id() {
    CONTAINERS=($(giddyup service containers -n))
    for i in "${!CONTAINERS[@]}"; do
       if [[ "${CONTAINERS[$i]}" = "${SELF_NAME}" ]]; then
           echo "${i}";
       fi
    done
}
