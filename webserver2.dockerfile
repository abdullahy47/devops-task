FROM php:8.1-apache-bullseye

WORKDIR /var/www/html

ENV ACCEPT_EULA=Y

RUN apt-get update && apt-get install -y gnupg2
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list


RUN apt-get update && apt-get install -y unixodbc-dev
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18

RUN pecl channel-update pecl.php.net

RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

RUN service apache2 restart


COPY QuickDbTest.php /var/www/html/

COPY index.html /var/www/html/
COPY info.php /var/www/html/

EXPOSE 80

CMD ["apache2-foreground"]

# codes below may be useful in other different projects and tasks -- just an information
##

#RUN apt-get update \
#&& apt-get install unixodbc unixodbc-dev -y \
#&& docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
#&& docker-php-ext-install pdo_odbc

#RUN docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
#&& docker-php-ext-install pdo_odbc

#RUN docker-php-ext-install pdo pdo_mysql
#RUN docker-php-ext-enable sqlsrv pdo_sqlsrv pdo pdo_mysql






