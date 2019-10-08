FROM php:5.6-apache
MAINTAINER kamranazeem@gmail.com

# This image is created to cater for the basic needs of openemr 5.0.0 software.
# Having this image means we do not have to waste time compiling php modues everytime.


# Following php modules are already part of official PHP image , so no need to re-install them:
#   (use `php -m` in the base image to find the list of already installed/Compiled modules)
# ---------------------------------------------------------------------------------------------
# * Core ctype curl date dom fileinfo filter ftp hash iconv json libxml mbstring mysqlnd 
# * openssl pcre PDO pdo_sqlite Phar posix readline Reflection session SimpleXML 
# * sodium SPL sqlite3 standard tokenizer xml xmlreader xmlwriter zlib  


# Useful tools to find stuff on debian:
# ------------------------------------
# apt-cache search libxml2
# apt-file find png.h 


# Following are part of openemr dockerfile but not found in PHP's official image: 
# -------------------------------------------------------------------------------
# redis - Why do we need it?

# What are these OS packages? and why are they needed/used in openemr docker image?
# ----------------------------------------------------------------------------------
# perl nodejs nodejs-npm \
# python openssl py-pip openssl-dev dcron shadow \
# git build-base libffi-dev python-dev \


#########################################################################################################
#
# Start building the image:
#
# Note: docker-php-ext-install also enables the module after installation.
#

RUN apt-get -y update \
 && apt-get -y install apt-utils libldap2-dev libpng-dev libxml2-dev libxslt1-dev libzip-dev libfreetype6-dev \
    libjpeg62-turbo-dev tar curl imagemagick mariadb-client net-tools unzip iputils-ping \
 && apt-get -y autoremove \
 && apt-get -y clean \
 && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
 && docker-php-ext-install calendar gd ldap mysqli pdo_mysql soap sockets xsl zip \
 && a2enmod headers allowmethods


# 
# Main build process complete here.
#
#########################################################################################################



CMD ["apache2-foreground"]


# Adjust other aspects of the image:
####################################

# If you want to use the php.ini which comes with the official PHP image,
#   then use the following:
# mv ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini

# If you want to customize php.ini settings, then copy in custom-php.ini file inside ${PHP_INI_DIR}/conf.d/ :
# COPY php.devpc.ini ${PHP_INI_DIR}/conf.d/

# Place in any httpd customization:
# COPY my-httpd-customization.conf /etc/apache2/conf-enabled/



# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> End of main Dockerfile <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



##################################################
# Build instructions:
# docker build -t kamranazeem/php:5.6-apache .
##################################################

