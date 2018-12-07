version: '2'
services:
  cerebro:
    image: 'dmacedo/cerebro:0.6.5'
    labels:
      io.rancher.container.hostname_override: container_name
    links:
      - 'elasticsearch-data:elasticsearch-data'
    stdin_open: true
    tty: true

  curator:
    environment:
      - 'ELASTICSEARCH_HOST=elasticsearch-data'
      - 'ELASTICSEARCH_PORT=9200'
      - 'MAX_INDEX_AGE=15'
    image: sxmichael/curator-docker
    links:
      - 'elasticsearch-data:elasticsearch-data'
    stdin_open: true
    tty: true

  elasticsearch-client:
    cap_add:
      - IPC_LOCK
    depends_on:
      - elasticsearch-master
    environment:
      - 'bootstrap.memory_lock=true'
      - 'cluster.name=${cluster_name}'
      - 'discovery.zen.ping.unicast.hosts=elasticsearch-master'
      - 'ES_JAVA_OPTS=-Xms${client_heap_size} -Xmx${client_heap_size}'
      - 'node.data=false'
      - 'node.master=false'
      - 'node.name=$${HOSTNAME}'
      - 'xpack.graph.enabled=false'
      - 'xpack.ml.enabled=false'
      - 'xpack.monitoring.enabled=false'
      - 'xpack.security.enabled=false'
      - 'xpack.watcher.enabled=false'
    image: 'docker.elastic.co/elasticsearch/elasticsearch:5.4.1'
    labels:
      io.rancher.container.hostname_override: container_name
      'io.rancher.scheduler.affinity:container_label_soft_ne': 'io.rancher.stack_service.name=$${stack_name}/$${service_name}'
      io.rancher.sidekicks: elasticsearch-storage
      {{- if eq .Values.UPDATE_SYSCTL "true" -}}
        ,elasticsearch-sysctl
      {{- end}}
    mem_limit: '${client_mem_limit}'
    mem_swappiness: 0
    ulimits:
      memlock:
        hard: -1
        soft: -1
      nofile:
        hard: 65536
        soft: 65536
    volumes_from:
      - elasticsearch-storage

  elasticsearch-data:
    cap_add:
      - IPC_LOCK
    depends_on:
      - elasticsearch-master
    environment:
      - 'bootstrap.memory_lock=true'
      - 'cluster.name=${cluster_name}'
      - 'discovery.zen.ping.unicast.hosts=elasticsearch-master'
      - 'ES_JAVA_OPTS=-Xms${data_heap_size} -Xmx${data_heap_size}'
      - 'node.data=true'
      - 'node.master=false'
      - 'node.name=$${HOSTNAME}'
      - 'xpack.graph.enabled=false'
      - 'xpack.ml.enabled=false'
      - 'xpack.monitoring.enabled=false'
      - 'xpack.security.enabled=false'
      - 'xpack.watcher.enabled=false'
    image: 'docker.elastic.co/elasticsearch/elasticsearch:5.4.1'
    labels:
      io.rancher.container.hostname_override: container_name
      'io.rancher.scheduler.affinity:container_label_soft_ne': 'io.rancher.stack_service.name=$${stack_name}/$${service_name}'
      io.rancher.sidekicks: elasticsearch-storage
      {{- if eq .Values.UPDATE_SYSCTL "true" -}}
        ,elasticsearch-sysctl
      {{- end}}
    mem_limit: '${data_mem_limit}'
    mem_swappiness: 0
    ulimits:
      memlock:
        hard: -1
        soft: -1
      nofile:
        hard: 65536
        soft: 65536
    volumes_from:
      - elasticsearch-storage

  elasticsearch-master:
    cap_add:
      - IPC_LOCK
    environment:
      - 'bootstrap.memory_lock=true'
      - 'cluster.name=${cluster_name}'
      - 'discovery.zen.minimum_master_nodes=${minimum_master_nodes}'
      - 'discovery.zen.ping.unicast.hosts=elasticsearch-master'
      - 'ES_JAVA_OPTS=-Xms${master_heap_size} -Xmx${master_heap_size}'
      - 'node.data=false'
      - 'node.master=true'
      - 'node.name=$${HOSTNAME}'
      - 'xpack.graph.enabled=false'
      - 'xpack.ml.enabled=false'
      - 'xpack.monitoring.enabled=false'
      - 'xpack.security.enabled=false'
      - 'xpack.watcher.enabled=false'
    image: 'docker.elastic.co/elasticsearch/elasticsearch:5.4.1'
    labels:
      io.rancher.container.hostname_override: container_name
      'io.rancher.scheduler.affinity:container_label_soft_ne': 'io.rancher.stack_service.name=$${stack_name}/$${service_name}'
      io.rancher.sidekicks: elasticsearch-storage
      {{- if eq .Values.UPDATE_SYSCTL "true" -}}
        ,elasticsearch-sysctl
      {{- end}}
    mem_limit: '${master_mem_limit}'
    mem_swappiness: 0
    ulimits:
      memlock:
        hard: -1
        soft: -1
      nofile:
        hard: 65536
        soft: 65536
    volumes_from:
      - elasticsearch-storage

  elasticsearch-storage:
    environment:
      - 'SERVICE_GID=1000'
      - 'SERVICE_UID=1000'
      - 'SERVICE_VOLUME=/usr/share/elasticsearch/data'
    image: 'rawmind/alpine-volume:0.0.2-1'
    labels:
      io.rancher.container.start_once: true
    network_mode: none
    volumes:
      - 'elasticsearch-storage-volume:/usr/share/elasticsearch/data'

  elasticsearch-sysctl:
    environment:
      - 'SYSCTL_KEY=vm.max_map_count'
      - 'SYSCTL_VALUE=262144'
    image: 'rawmind/alpine-sysctl:0.1'
    labels:
      io.rancher.container.start_once: true
    network_mode: none
    privileged: true

  kibana:
    environment:
      - 'ELASTICSEARCH_URL=http://elasticsearch-client:9200'
      - 'xpack.graph.enabled=false'
      - 'xpack.ml.enabled=false'
      - 'xpack.monitoring.enabled=false'
      - 'xpack.security.enabled=false'
      - 'xpack.watcher.enabled=false'
    image: 'docker.elastic.co/kibana/kibana:5.4.1'
    labels:
      io.rancher.container.hostname_override: container_name
    links:
      - 'elasticsearch-data:elasticsearch-data'
    stdin_open: true
    tty: true

  logspout:
    environment:
      - 'LOGSPOUT=ignore'
      - 'ROUTE_URIS=logstash://logstash:5000'
    image: 'dmacedo/logspout-logstash:v1.0.0'
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.global: 'true'
    links:
      - 'logstash-collector:logstash'
    stdin_open: true
    tty: true
    volumes:
      - '/var/run/docker.sock:/var/run/docker.sock'

  logstash-collector:
    command:
      - logstash
      - '-f'
      - /etc/logstash
    image: 'docker.elastic.co/logstash/logstash:5.4.1'
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: logstash-collector-config
    links:
      - 'redis:redis'
    ports:
      - '5000:5000/udp'
      - '25826:25826/udp'
    restart: always
    stdin_open: true
    tty: true
    volumes_from:
      - logstash-collector-config

  logstash-collector-config:
    image: 'rancher/logstash-config:v0.2.0'
    labels:
      io.rancher.container.hostname_override: container_name
    restart: always

  logstash-indexer:
    command:
      - logstash
      - '-f'
      - /etc/logstash
    image: 'docker.elastic.co/logstash/logstash:5.4.1'
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: logstash-indexer-config
    links:
      - 'redis:redis'
      - 'elasticsearch-data:elasticsearch-data'
    restart: always
    stdin_open: true
    tty: true
    volumes_from:
      - logstash-indexer-config

  logstash-indexer-config:
    image: 'rancher/logstash-config:v0.2.0'
    labels:
      io.rancher.container.hostname_override: container_name
    restart: always

  redis:
    image: 'redis:3.2.9'
    labels:
      io.rancher.container.hostname_override: container_name
    restart: always
    stdin_open: true
    tty: true

volumes:
  elasticsearch-storage-volume:
    driver: local
    per_container: true
