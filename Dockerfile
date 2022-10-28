FROM php:8.2.0RC5-zts-alpine3.16

RUN apk update && apk upgrade && apk add --no-cache libmcrypt-dev bash 
# Install symfony
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash
RUN apk add symfony-cli
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . /app

RUN composer install

EXPOSE 8000
CMD symfony server:start --port=8000

# FROM php:7.2-cli

# RUN apt-get update -y && apt-get install -y libmcrypt-dev

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN docker-php-ext-install pdo mbstring

# WORKDIR /app
# COPY . /app

# RUN composer install

# EXPOSE 8000
# CMD php bin/console server:run 0.0.0.0:8000
