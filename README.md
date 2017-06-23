PHP7 FPM + Nginx
================

Docker image used to run PHP7 applications using nginx and php-fpm built on top of a Centos7 base image.

How to use this image
---------------------

## Create a Dockerfile

```
FROM crowdcube/php-nginx:latest

COPY ./ /your/document/root
COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

WORKDIR /your/document/root
```

The `nginx.conf` file should look like this:

```
server {
  listen 80;
  root /your/document/root;
  index index.php index.htm index.html;

  location / {
      try_files $uri $uri/ /index.php?$query_string;
  }

  location /index.php {
      include fastcgi_params;
      fastcgi_connect_timeout 10s;
      fastcgi_read_timeout 10s;
      fastcgi_buffers 256 4k;
      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
      fastcgi_pass 127.0.0.1:9000;
  }
}
```

The most important part of the Nginx configuration is the `location /index.php` block as it's the one that will allow the fast-cgi to php-fpm.

## Without a Dockerfile

If you don't want to include a Dockerfile in your project, it is sufficient to do the following:

```
$ docker run -d -p 8080:80 --name my-php-app -v "$PWD":/your/document/root crowdcube/php-nginx:latest
```
