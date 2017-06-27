Zabbix rancher stack

Zabbix XXL is a standard Zabbix prepared for Docker world. You must install Zabbix package (rpm, deb, ...) in the old world. Similarly, you need to pull Zabbix Docker image in the Docker world. This Docker image contains standard Zabbix + additional XXL (community) extensions. Routine tasks such as import of Zabbix DB are automated, so it's prepared for easy deployment.

If you like or use this project, please provide feedback to author - Star it ★.

Overview of Monitoring Artist (dockerized) monitoring ecosystem:

    Zabbix XXL - standard Zabbix 3.x server/proxy/UI/snmpd/java gateway with additional XXL extensions
    Zabbix agent XXL - Zabbix 3.0 agent with Docker (Mesos/Chronos/Marathon) monitoring and systemd monitoring
    Zabbix templates - tiny (5MB) image for easy template deployment of selected Zabbix monitoring templates
    Zabbix extension - all templates - storage image for Zabbix XXL with 200+ community templates
    Kubernetized Zabbix - containerized Zabbix cluster based on Kubernetes
    Grafana XXL - dockerized Grafana with all community plugins
    Grafana dashboards - Grafana dashboard collection for AWS and Zabbix
    Monitoring Analytics - R statistical computing and graphics for monitoring from data scientists
    Docker killer - Docker image for Docker stress and Docker orchestration testing
