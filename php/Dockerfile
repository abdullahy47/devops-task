FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl software-properties-common

# Install PHP (Ubuntu)
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update
RUN apt-get install php8.1 php8.1-dev php8.1-xml -y --allow-unauthenticated

# Install the ODBC driver (Ubuntu)
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools18
RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
RUN source ~/.bashrc
RUN apt-get install -y unixodbc-dev

# Install the PHP drivers for Microsoft SQL Server (Ubuntu)
RUN pecl channel-update pecl.php.net
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.1/mods-available/sqlsrv.ini
RUN printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.1/mods-available/pdo_sqlsrv.ini
RUN phpenmod -v 8.1 sqlsrv pdo_sqlsrv
RUN echo "extension=sqlsrv.so" >> /etc/php/8.1/apache2/php.ini
RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/8.1/apache2/php.ini

# Install Apache (Ubuntu)
RUN apt-get install libapache2-mod-php8.1 apache2

# Copy php script to the root folder of Apache2
COPY quickdbtest.php /var/www/html/quickdbtest.php

# Run Apache2 Server
ENV APACHE_ENVVARS=/etc/apache2/envvars
CMD ["apache2ctl", "-D", "FOREGROUND"]