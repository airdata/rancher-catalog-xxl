readme under version 10


rancher-catalog-service
=======================
REST Service enables a user to view a catalog of pre-cooked templates stored on a git repo. Also the user can launch the templates onto a specific Rancher environment.

Design
==========
* rancher-catalog-service gets deployed as a Rancher service containerized app. 

* rancher-catalog-service will clone a git repo (e.g. a public github repo) and provide API to list and navigate through the templates and subversions from the repo

* The service will periodically sync changes from the repo

* The UI integrated with the service will enable the user to view the templates in a catalog format and also launch a template to a specified rancher deployment.

Building
========

This project uses [dapper](https://github.com/ibuildthecloud/dapper).  Install dapper first

    go get github.com/ibuildthecloud/dapper

```sh
# Compile
dapper build
