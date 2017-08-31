OpenEdx Stack
=============

#### About OpenEdX
[OpenEdX](https://open.edx.org/) is the LMS platform behind [edX](https://www.edx.org/). An overview of the OpenEdX Architecture can be found [here](https://edx.readthedocs.io/projects/edx-developer-guide/en/latest/architecture.html).

#### About this stack
This stack is based on the OpenEdX docker implementation in the [EdX configuration repo](https://github.com/edx/configuration/tree/master/docker). It has however been modified to allow minor customisations to the config, namely domain names and platform name. The forked repo can be found under [OpensaasAU on github](https://github.com/OpenSaasAU/edx-configuration). The stock docker images (mysql, mongo, rabbitmq, and nginx) were used where ever possible. Edx uses ansible to config and these sripts are set to run on launch to ensure correct configuration.

#### How to use
1. Fill out the custom information and storage locations, note some storage locations are shared between containers so shared storage should be used.
2. Setup an initial django/openedx super user by executing a shell on lms and running and running the following commands:
```bash
cd /edx/app
source edxapp/edxapp_env
python /edx/app/edxapp/edx-platform/manage.py lms --settings aws create_user -s -p edx -e user@example.com
python /edx/app/edxapp/edx-platform/manage.py lms --settings aws changepassword user
```
For more info on managing the edx application have a [look here](https://openedx.atlassian.net/wiki/display/OpenOPS/Managing+OpenEdX+Tips+and+Tricks)

Any further platform customisation can be done by upgrading the cms and lms services and adding overrides to the ansible command.
