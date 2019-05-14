#
# Dockerfile for mantisbt
#

FROM php:5.5-apache
MAINTAINER brlumen <igflocal@gmail.com>

RUN a2enmod rewrite

RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mbstring mysqli pgsql soap \
    && pecl install xdebug-2.6.1 \
    && docker-php-ext-enable xdebug \
    && rm -rf /var/lib/apt/lists/*
