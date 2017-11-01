# rgon-proxy

RGON-Proxy is an Service including Nginx and Letsencrypt to proxy incoming Trafic to the related containers.

Related containers can be defined with following labels:

- `rgon.domain=mydomain.com`
- `rgon.port=80`
- `rgon.ssl='true'`
- `rgon.redirect=https`
- `rgon.stats=1.1.1.1`

For a detailed Readme head to:
https://github.com/CausticLab/rgon-proxy/blob/dev/README.md