## What is inside JIRA Stack?
* [JIRA Server](https://hub.docker.com/r/matisq/jira-server/) + sidekick with volume data
* Postgres Database + sidekick with volume data

## Info
* In default JIRA stack will create `jiradb` postgres database with `jira` user.  
* Additional variables `http_proxy` and `https_proxy` are included, which can be helpful in some cases.
* Once JIRA Server will start, make sure you setup correct information in setup page.
* For easy upgrades there are sidekicks for both Postgres and JIRA Server with dedicated storage.

## Known Issues
JIRA Server during installation can be slow at configuration, so Load Balancer can think that Server is down. If so just reload page `http://you-rancher-host/secure` after a few minutes. This was observed only during installation.
