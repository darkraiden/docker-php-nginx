FROM centos:7

ENV SHELL /bin/bash
ENV PHP_REPO http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
ENV PHP_OWNER nginx
ENV PHP_GROUP nginx
ENV PHP_MAX_CHILDREN 50
ENV PHP_MEMORY_LIMIT 128

ENV PACKAGES \
              nginx \
              supervisor \
              wget \
              gettext-0.19.8.1-2.el7.x86_64 \
              php-fpm \
              php-cli \
              php-pear \
              php-devel \
              php-xml \
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
              librabbitmq-devel \
              php-pecl-amqp \
              php-pgsql

#Install php-fpm and any required packages
RUN yum -y install $PHP_REPO &&\
    yum --enablerepo=remi,remi-php71 install -y $PACKAGES &&\
    yum clean all

#Copy www.conf file to container
COPY ./www.conf /etc/php-fpm.d/www.conf
COPY ./php.ini /etc/php.ini
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./host.template /etc/nginx/conf.d/host.template

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
