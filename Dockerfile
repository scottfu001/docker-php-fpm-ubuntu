FROM ubuntu:bionic
MAINTAINER  Scott Fu <scott.fu@oulook.com>

#enviroment variables
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# some missing pkgs
RUN apt-get update && apt-get install -y --no-install-recommends dialog apt-utils

# build required libs
RUN apt-get install -y locales curl vim git software-properties-common && \
	locale-gen en_US.UTF-8 

# packages installation
RUN apt-get install -y \
	php-apcu \
	php-ast \
	php-bcmath \
	php-bz2 \
	php-calendar \
	php-cgi \
	php-cli \
	php-common \
	php-curl \
	php-date \
	php-db \
	php-deepcopy \
	php-directory-scanner \
	php-dompdf \
	php-email-validator \
	php-enchant \
	php-fdomdocument \
	php-fpdf \
	php-fpm \
	php-gd \
	php-geoip \
	php-imagick \
	php-gmp \
	php-imap \
	php-intl \
	php-json \
	php-ldap \
	php-mbstring \
	php-mysql \
	php-odbc \
	php-opcache \
	php-pgsql \
	php-phpdbg \
	php-pspell \
	php-readline \
	php-redis \
	php-recode \
	php-soap \
	php-sqlite3 \
	php-tidy \
	php-xml \
	php-xmlrpc \
	php-xsl \
	php-zip \
	php-mongodb
	
# basic config
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/upload_max_filesize = .*/upload_max_filesize = 10M/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/post_max_size = .*/post_max_size = 10M/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini

# make it docker friendly and runable by docker-compose
RUN sed -i -e "s/pid =.*/pid = \/var\/run\/php7.2-fpm.pid/" /etc/php/7.2/fpm/php-fpm.conf
RUN sed -i -e "s/error_log =.*/error_log = \/proc\/self\/fd\/2/" /etc/php/7.2/fpm/php-fpm.conf
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf
RUN sed -i "s/listen = .*/listen = 9000/" /etc/php/7.2/fpm/pool.d/www.conf
RUN sed -i "s/;catch_workers_output = .*/catch_workers_output = yes/" /etc/php/7.2/fpm/pool.d/www.conf

# install composer	
RUN curl https://getcomposer.org/installer > composer-setup.php && php composer-setup.php && mv composer.phar /usr/local/bin/composer && rm composer-setup.php

# clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get autoremove

# volumn
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html
VOLUME ["/var/www/html"]
WORKDIR /var/www/html

# port
EXPOSE 9000

# entry point
CMD ["php-fpm7.2"]
