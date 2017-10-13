version: '2'
volumes:
  elasticsearch-storage-volume:
    driver: ${VOLUME_DRIVER}
services:
  elasticsearch-storage:
    image: rawmind/alpine-volume:0.0.2-1
    environment:
      SERVICE_GID: '1000'
      SERVICE_UID: '1000'
      SERVICE_VOLUME: /usr/share/elasticsearch/data
    network_mode: none
    volumes:
    - elasticsearch-storage-volume:/usr/share/elasticsearch/data
    labels:
      io.rancher.container.start_once: 'true'

  elasticsearch-sysctl:
    labels:
        io.rancher.container.start_once: true
    network_mode: none
    image: rawmind/alpine-sysctl:0.1
    privileged: true
    environment:
    - "SYSCTL_KEY=vm.max_map_count"
    - "SYSCTL_VALUE=262144"

  elasticsearch:
    mem_limit: 1073741824
    cap_add:
    - IPC_LOCK
    image: docker.elastic.co/elasticsearch/elasticsearch:5.5.0
    environment:
      ES_JAVA_OPTS: -Xms512m -Xmx512m
      bootstrap.memory_lock: 'true'
      cluster.name: elasticsearch-cluster-log
      discovery.zen.minimum_master_nodes: '1'
      discovery.zen.ping.unicast.hosts: elasticsearch
      node.data: 'true'
      node.master: 'true'
      node.name: $${HOSTNAME}
      xpack.security.enabled: 'false'
    ulimits:
      memlock:
        hard: -1
        soft: -1
      nofile:
        hard: 262144
        soft: 262144
    volumes_from:
    - elasticsearch-storage
    labels:
      io.rancher.sidekicks: elasticsearch-storage, elasticsearch-sysctl
      io.rancher.container.hostname_override: container_name

  logstash-config:
    image: rancher/logstash-config:v0.2.0
    labels:
      io.rancher.container.hostname_override: container_name

  logstash:
    image: docker.elastic.co/logstash/logstash:5.5.0
    stdin_open: true
    tty: true
    links:
    - elasticsearch
    volumes_from:
    - logstash-config
    ports:
    - 57584:5000/udp
    - 61597:6000/tcp
    command:
    - logstash
    - -f
    - /etc/logstash
    labels:
      io.rancher.sidekicks: logstash-config
      io.rancher.container.hostname_override: container_name
    depends_on:
    - elasticsearch

  kibana:
    image: docker.elastic.co/kibana/kibana:5.5.0
    environment:
      ELASTICSEARCH_URL: http://elasticsearch:9200
    stdin_open: true
    links:
    - elasticsearch
    tty: true
    labels:
      io.rancher.container.hostname_override: container_name
      backend: kibana
    depends_on:
    - elasticsearch

  logspout:
    image: bekt/logspout-logstash:latest
    links:
    - logstash
    environment:
      ROUTE_URIS: "logstash://logstash:5000"
      LOGSPOUT: 'ignore'
      SYSLOG_HOSTNAME: "Rancher:Test"
    volumes:
    - '/var/run/docker.sock:/var/run/docker.sock'
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.container.hostname_override: container_name
    tty: true
    stdin_open: true
    depends_on:
    - logstash

  curator:
    image: throrin19/elasticsearch-curator:5.2.0
    links:
    - elasticsearch
    depends_on:
    - elasticsearch
    labels:
      io.rancher.container.hostname_override: container_name
    tty: true
    stdin_open: true
    environment:
      INTERVAL_IN_HOURS: ${curator_interval}
      OLDER_THAN_IN_DAYS: ${curator_days}

  {{- if eq .Values.METRICBEAT "true" }}
  metricbeat:
    image: docker.elastic.co/beats/metricbeat:5.5.0
    stdin_open: true
    network_mode: host
    volumes:
    - /proc:/hostfs/proc:ro
    - /sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro
    - /:/hostfs:ro
    tty: true
    links:
    - elasticsearch
    labels:
      io.rancher.container.dns: 'true'
      io.rancher.container.pull_image: always
      io.rancher.scheduler.global: 'true'
    depends_on:
    - elasticsearch
  {{- end}}

  {{- if eq .Values.PACKETBEAT "true" }}
  packetbeat:
    cap_add:
    - NET_ADMIN
    - NET_RAW
    image: docker.elastic.co/beats/packetbeat:5.5.0
    stdin_open: true
    network_mode: host
    tty: true
    links:
    - elasticsearch
    labels:
      io.rancher.container.dns: 'true'
      io.rancher.container.pull_image: always
      io.rancher.scheduler.global: 'true'
    depends_on:
    - elasticsearch
  {{- end}}
