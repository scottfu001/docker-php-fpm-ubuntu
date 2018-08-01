This is base on Ubuntu 18.04 and has the following modules with it

PHP version is 7.0 and build from official Ubuntu repo

Port 9000 is exposed

This build has following modules

[PHP Modules]

apc  apcu  ast

bcmath bz2

calendar Core ctype curl

date dom 

enchant exif

fileinfo filter ftp

gd geoip gettext gmp hash iconv

igbinary imagick imap intl 

json

ldap libxml

mbstring mongodb mysqli mysqlnd

odbc openssl

pcntl pcre PDO pdo_mysql PDO_ODBC pdo_pgsql pdo_sqlite pgsql Phar posix pspell

readline recode redis Reflection

session shmop SimpleXML soap sockets sodium SPL sqlite3 standard sysvmsg sysvsem sysvshm

tidy tokenizer

wddx

xml xmlreader xmlrpc xmlwriter xsl

zip zlib

[Zend Modules]

Zend OPcache


Docker Compose Example

    php:     
        image: scottfu/php-fpm-ubuntu
        restart: on-failure
        container_name: php
        volumes:
            - "/etc/timezone:/etc/timezone:ro"
            - "./config/php/php.ini:/usr/local/config/php/conf.d/php.ini"
            - "./resources/www:/var/www/html"
        tty: true
