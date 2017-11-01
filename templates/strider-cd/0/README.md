<h1>Strider CD</h1>

From [https://github.com/emcniece/rancher-catalog](https://github.com/emcniece/rancher-catalog)

This catalog item consists of MongoDB, [Postfix](https://github.com/panubo/docker-postfix), and [Strider CD](https://github.com/macropin/docker-strider).

The **Storage Directory** variable exposes a volume for each service:

- `./mongo:/data/db`
- `./smtp:/var/spool/postfix`
- `./strider:/data`

SMTP credentials can be overridden by filling out the variable fields, otherwise the Postfix container will send mail.

Environment variables are available for the [Strider Github provider](https://github.com/Strider-CD/strider-github). This can be enabled via the plugins screen once Strider is running.