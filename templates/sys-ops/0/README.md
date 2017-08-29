# System OPS

### Features v0.1:

* LB - Load Balancer (rancher/lb-service-haproxy:v0.7.1) (scheduled GLOBALLY)
* Janitor - Clean Old Docker images (meltwater/docker-cleanup:1.8.0) (scheduled GLOBALLY exclusions possible)
* Foreman - Orchestrate puppets (nexus.lab:8860/foreman) (scheduled on hosts with tag env=ops)
* ELK-slave - Data node to help ELK master (elasticsearch:2.4.4) (scheduled on hosts with tag env=ops)
* Jenkins-slave - Build node to help Jenkins master (nexus.lab:8860/jenkins-slave:latest)


