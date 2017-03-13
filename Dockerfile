FROM php:5-apache

##############################################################################
###	Install PHP extensions from PEAR/PECL:
###	- MongoDB driver
###
### build-essential: needed for PECL to compile
### php5-dev: needed to provide 'phpize' command
##############################################################################
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
      build-essential \
      php5-dev \
  && \
  pecl channel-update pecl.php.net && \
  pecl install mongo && \
  rm -vrf /build /tmp/pear && \
  echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y autoremove --purge \
      build-essential \
      php5-dev \
  && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /var/log/apt/*

ADD ./moadmin.php /var/www/html/index.php
