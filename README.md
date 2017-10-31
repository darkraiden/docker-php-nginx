PHP7 FPM + Nginx
================

Docker image used to run PHP7 applications using nginx and php-fpm built on top of a Centos7 base image.

How to use this image
---------------------

## Create a Dockerfile

```
FROM crowdcube/php-nginx:latest

ENV NGINX_PORT 80
ENV NGINX_DOCUMENT_ROOT /your/document/root/http

RUN /bin/bash -c "envsubst '\$NGINX_PORT \$NGINX_DOCUMENT_ROOT' < /etc/nginx/conf.d/host.template > /etc/nginx/conf.d/product.conf"

COPY ./ /your/document/root

WORKDIR /your/document/root
```

The `host.template` is part of the `crowdcube/php-nginx:1.1` image.

## Without a Dockerfile

If you don't want to include a Dockerfile in your project, it is sufficient to do the following:

```
$ docker run -d -p 8080:80 -e NGINX_PORT=80 -e NGINX_DOCUMENT_ROOT /your/document/root/http --name my-php-app -v "$PWD":/your/document/root crowdcube/php-nginx:latest
```
