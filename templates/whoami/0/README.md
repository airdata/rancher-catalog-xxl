<h1>WhoAmI</h1>

From [https://github.com/emcniece/rancher-catalog](https://github.com/emcniece/rancher-catalog)

This catalog item consists of [emilevauge/whoamI](https://github.com/emilevauge/whoamI). This service outputs some basic container info that is useful for debugging.

Sample output:

```
Hostname: ef0c0d7bbe3b
IP: 127.0.0.1
IP: ::1
IP: 172.17.0.5
IP: 15.11.52.283
IP: ac12::92:a5c3:d9fa:1234
GET / HTTP/1.1
Host: 123.45.67.890:62264
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-CA,en;q=0.8,en-US;q=0.6
Connection: keep-alive
Cookie: PL=rancher; CSRF=123; _ga=GA1.2.3.4; _gat=1
Dnt: 1
Referer: http://rancher.mysite.com:8080/env/1a5/apps/stacks/1st4
Upgrade-Insecure-Requests: 1
```

If the HTTP port variable is left blank, Rancher will choose a random port for the service.

This service can be added in "Global" mode, which sets the `io.rancher.scheduler.global` label to `true` and deploys one of these containers to each host in the environment.

The `VIRTUAL_*` and `LETSENCRYPT_*` environment variables are added for use with the [Let's Encrypt Nginx Proxy]() service. If these are filled out, this container can be accessed from a domain name and optionally with an SSL certificate.