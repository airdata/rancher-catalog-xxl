# Drone Agent(s)

### Info

This template will launch a configurbale number of Drone agents to auto-register to the specified Drone server Service.

### Usage

#### drone_service

Link to the Drone server Service. Maps to DRONE_SERVER.

#### drone_service_tcp_port

Drone Service TCP port. Defaults to '8000'.

#### dronerc_contents

Raw text to be concatenated into /etc/drone/dronerc. Specify various DRONE_* options here. Do not specify DRONE_SERVER as that is handled via the drone_service input. See [Drone documentation](http://readme.drone.io/0.5/usage/overview/) for complete information.

#### drone_agent_count

Number of Drone Agents to spin. Agents will be spun with soft anti-affinity.

#### host_affinity

Specificy a host label for node scheduling affinity. Example: If you have labelled the node(s) on which you would like Drone Agent to live 'ci.role=drone_agent' specify 'ci.role=drone_agent' here.

#### debug_mode

Enable verbose logging of container startup as well as DRONE_DEBUG in the spun Drone Agents. Beware enabling this option may expose credentials and other sensitive information in Rancher log files and container stdout/stderr.

### Notes

A minimal set of configuration looks something like the following. Details will vary according to your environment:

```ShellSession
export DRONE_SECRET='<password>'  # The shared secret to allow auto-registration of Drone Agents.
                                  # This value must match DRONE_SECRET on the Drone Server.
````


### Development / Bug Reports / Feedback

The Drone Agent(s) Cattle template resides in a repo alongside other Rancher community Catalog templates at:

[https://github.com/rancher/community-catalog](https://github.com/rancher/community-catalog)

however development happens in the following repo:

[https://github.com/nrvale0/community-catalog](https://github.com/nrvale0/community-catalog)
