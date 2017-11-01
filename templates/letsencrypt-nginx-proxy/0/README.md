<h1>Let's Encrypt Nginx Proxy</h1>

From [https://github.com/Munsio/docker-letsencrypt-nginx-proxy-companion/](https://github.com/Munsio/docker-letsencrypt-nginx-proxy-companion)

This catalog item consists of the recommended setup for JWilder's NGINX Proxy - 3 containers:

- nginx
- nginx-gen
- nginx-letsencrypt

Before installing, ensure that the storage directory exists and `${DIR}/templates/nginx.tmpl` contains the contents of a template [like this one](https://gist.github.com/emcniece/9193055dc777af203db8bb18ac8a0a25).