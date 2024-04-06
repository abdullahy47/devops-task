# Use the official PHP 8.1 image as base image
FROM php:8.1

# Install MSSQL dependencies
RUN apt-get update && \
    apt-get install -y \
        unixodbc \
        unixodbc-dev \
        freetds-bin \
        freetds-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install and enable the MSSQL (sqlsrv and pdo_sqlsrv) extensions
RUN pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# Set recommended PHP.ini settings for development
RUN { \
        echo 'error_reporting = E_ALL'; \
        echo 'display_errors = On'; \
        echo 'log_errors = On'; \
        echo 'error_log = /dev/stderr'; \
    } > /usr/local/etc/php/conf.d/php.ini

# Set timezone
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

EXPOSE 80

# Set working directory
COPY ./app/index.php /var/www/html 
# SONRADAN EKLEDİM COPY SATIRINI
WORKDIR /var/www/html

# Start your application (if required)
CMD ["php", "index.php"]
