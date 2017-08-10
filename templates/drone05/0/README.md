# Drone Server

### Info:

This template creates an instance of Drone CI Server version 0.5(December 2016 master).

### Usage

#### dronerc_contents

Raw text to be concatenated into /etc/drone/dronerc. See [Drone documentation](http://readme.drone.io/0.5/usage/overview/) for complete information.

#### public_port

TCP port on which users and Drone Agents may interact with the Drone Service.

#### default_cert
	
Required SSL certificate used for encryption of the traffic between web browsers and the Drone Server UI.

#### database_service

MySQL-based database Service which the Drone Server will use to maintain state of the Drone infrastructure.

#### host_affinity

Specificy a host label for node scheduling affinity. Example: If you have labelled the node(s) on which you would like Drone Server to live 'ci.role=drone_server' specify 'ci.role=drone_server' here.


#### debug_mode

Enable verbose logging of container startup as well as DRONE_DEBUG in the spun Drone Agents. Beware enabling this option may expose credentials and other sensitive information in Rancher log files and container stdout/stderr.

### Notes

A minimal set of configuration looks something like the following. Details will vary according to your environment:

```ShellSesssion
export DRONE_DEBUG='true'                       # enable debugging mode
export DRONE_SECRET='<password>'                # the shared secret to allow auto-registration of Drone Agents
export DRONE_GITHUB=1                           # enable the Drone GitHub integration
export DRONE_GITHUB_CLIENT='<GitHub app ID>     # GitHub oAuth application client hash
export DRONE_GITHUB_SECRET='<GitHub app secret> # GitHub oAuth application secret
export DRONE_DATABASE_DRIVER='mysql'            # enable the MySQL backend for state storage
export DRONE_OPEN=1                             # allow open registration of user accounts

# Drone datasource URI. See the Drone documentation for syntax/format.
export DRONE_DATABASE_DATASOURCE='drone:<password>@tcp(database:3306)/drone?parseTime=true'
```

__Note Rancher's Cattle template sets up a name alias (via 'external_links') such that names 'drone' and 'database' should always work in this URI.__

### Development / Bug Reports / Feedback

The Drone Server Cattle template resides in a repo alongside other Rancher community Catalog templates at:

[https://github.com/rancher/community-catalog](https://github.com/rancher/community-catalog)

however development happens in the following repo:

[https://github.com/nrvale0/community-catalog](https://github.com/nrvale0/community-catalog)
