# System OPS

###New Features v0.4:
* Nexus - Repository Managment
* Rundeck - Orchestration & Automation
* Kibana - Logging webinterface
* SFTP
Features v0.3
* LB - Load Balancer service mode (rancher/lb-service-haproxy:v0.7.1) (scheduled GLOBALLY)
* Janitor - Clean Old Docker images (meltwater/docker-cleanup:1.8.0) (scheduled GLOBALLY exclusions possible)
* Foreman - Orchestrate puppets (nexus.lab:8860/foreman) (scheduled on hosts with tag env=ops)
* ELK-slave - Data node to help ELK master (elasticsearch:2.4.4) (scheduled on hosts with tag env=ops)
* Zabbix-server - monitoringartist/zabbix-xxl:latest (sheduled on hosts with tag env=ops)
* Zabbix-agent - monitoringartist/zabbix-agent-xxl-limited:latest (scheduled GLOBALLY)

