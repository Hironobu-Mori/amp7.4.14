FROM php:7.4.14-apache

COPY ./php/php.ini /usr/local/etc/php/

RUN apt-get update \
&& apt-get install -y \
git \
zip \
unzip \
vim \
libpng-dev \
libpq-dev \
&& docker-php-ext-install pdo_mysql pdo_pgsql mysqli

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

RUN mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled
RUN /bin/sh -c a2enmod rewrite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

EXPOSE 80