FROM        clusterhq/flocker-dataset-agent:1.14.0

ADD         . /tmp/

RUN         chmod +x /tmp/setup.sh && ./tmp/setup.sh

CMD         ["/tmp/wrap_dataset_agent_mtab.sh"]
