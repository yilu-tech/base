FROM nginx:alpine

LABEL MAINTAINER="yilu-zzb"

RUN apk update \
 && apk add --no-cache php7 \
                       php7-fpm \
                       php7-openssl \
                       php7-pdo_mysql \
                       php7-mbstring \
                       php7-tokenizer \
                       php7-xml \
                       php7-xmlwriter \
                       php7-simplexml \
                       php7-dom \
                       php7-session \
                       php7-ctype \
                       php7-bcmath \
                       php7-json \
                       php7-phar \
                       php7-curl \
                       php7-iconv \
                       php7-mcrypt \
                       php7-gd \
                       php7-gmp \
                       php7-curl \
                       php7-fileinfo \
                       libbsd

# set php, nginx
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/php.ini

WORKDIR /root
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir=/usr/bin --filename=composer \
 && rm /root/composer-setup.php

RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

COPY startup /startup
RUN chmod +x /startup

CMD ["/startup"]