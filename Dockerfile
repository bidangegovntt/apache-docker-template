FROM php:7.4.28-apache
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install pdo && docker-php-ext-enable pdo
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql
RUN a2enmod rewrite
RUN a2enmod deflate
RUN a2enmod headers
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./apache/laravel.conf /etc/apache2/sites-available/laravel.conf
COPY ./apache/local.ini /usr/local/etc/php/conf.d/local.ini
COPY ./sik /var/www/html
RUN chown www-data:www-data /var/www/html -R
RUN a2dissite 000-default.conf
RUN a2ensite laravel