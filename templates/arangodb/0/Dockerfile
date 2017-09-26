FROM alpine:latest

ENV MONGO_SERVICE_NAME mongo

ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

VOLUME /opt/rancher/bin

ENTRYPOINT ["/bin/true"]
