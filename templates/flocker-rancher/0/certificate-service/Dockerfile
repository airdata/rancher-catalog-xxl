FROM        ubuntu:16.04

# Last build date - this can be updated whenever there are security updates so
# that everything is rebuilt
ENV         security_updates_as_of 2015-11-03


# Install security updates and required packages
RUN         apt-get -qy update && \
            apt-get -y install apt-transport-https software-properties-common wget zip curl git jq && \
            add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /" && \
            apt-get -qy update && \
            apt-get -y --force-yes install clusterhq-flocker-cli && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /app && \
            mkdir -p /etc/flocker && \
            chmod 0700 /etc/flocker

ENV         PATH /opt/flocker/bin:$PATH

ADD         . /app

RUN         chmod +x /app/setup.sh

WORKDIR     /etc/flocker

CMD         ["/app/setup.sh"]
