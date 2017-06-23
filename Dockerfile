FROM centos:7

ENV SHELL /bin/bash
ENV PHP_REPO http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
ENV PHP_OWNER nginx
ENV PHP_GROUP nginx
ENV PHP_MAX_CHILDREN 50
ENV PHP_MEMORY_LIMIT 128
ENV PACKAGES \
                 nginx \
                 php-fpm \
                 php-cli \
                 php-pear \
                 php-xml \
                 supervisor \
                 php-libxml \
                 php-intl \
                 php-pecl-oauth \
                 php-bcmath \
                 php-gmp \
                 php-gd \
                 php-soap \
                 php-openssl \
                 php-mysql \
                 php-mbstring \
                 php-tokenizer \
                 php-mcrypt \
                 php-bitset \
                 php-pecl-amqp \
                 php-pgsql

#Install base image deps
RUN yum install -y wget

#Install the REMI repo
RUN yum -y install $PHP_REPO

#Install php-fpm and any required packages
RUN yum --enablerepo=remi,remi-php71 install -y $PACKAGES &&\
    yum clean all

#Copy www.conf file to container
COPY ./www.conf /etc/php-fpm.d/www.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
