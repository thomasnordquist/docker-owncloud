FROM alpine
RUN apk update && \
        apk add \
        supervisor \
        nginx \
        php-fpm \
        php-gd \
        php-curl \
        php-iconv \
        php-zlib \
        php-zip \
        php-ctype \
        php-json \
        php-xml \
        php-xmlreader \
        php-dom \
        php-pdo \
        php-sqlite3 \
        php-pdo_sqlite \
        php-memcache \
        php-apcu

# fix permissions
RUN chown -R nginx:nginx /var/lib/nginx /var/log

COPY nginx.conf /etc/nginx/
COPY owncloud.conf /etc/nginx/sites-enabled.d/
COPY php-fpm.override.conf /etc/php/
COPY supervisord.conf entrypoint.sh /

RUN chmod +x /entrypoint.sh

# use unix socket instead of tcp
RUN cat /etc/php/php-fpm.override.conf >> /etc/php/php-fpm.conf && \
	rm /etc/php/php-fpm.override.conf

# Install owncloud & fix permissions
RUN curl https://download.owncloud.org/community/owncloud-9.0.1.tar.bz2 | \
	tar -xjC /var/www && \
	chown -R nginx:nginx /var/www/owncloud

WORKDIR /var/www/owncloud

VOLUME /var/log
VOLUME /var/www/owncloud/data

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

