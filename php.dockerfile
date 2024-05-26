FROM php:8.2.19-fpm-alpine

RUN mkdir -p /var/www/html

# Output the contents of /etc/apk/repositories for debugging purposes
RUN cat /etc/apk/repositories

# Update package list
RUN apk update

# Install necessary packages separately to identify issues
RUN apk add --no-cache freetype-dev
RUN apk add --no-cache libjpeg-turbo-dev
RUN apk add --no-cache libpng-dev
RUN apk add --no-cache oniguruma-dev
RUN apk add --no-cache libxml2-dev
RUN apk add --no-cache postgresql-dev
RUN apk add --no-cache shadow && usermod -u 1000 www-data


# Configure and install gd extension
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

# Install other PHP extensions
RUN docker-php-ext-install -j$(nproc) pdo pdo_pgsql bcmath
