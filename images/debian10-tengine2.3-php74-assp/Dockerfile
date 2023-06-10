FROM debian:10

COPY files/sources.list /tmp/
COPY files/tengine-2.3.3.tar.gz /tmp/
COPY files/php-7.4.24.tar.gz /tmp/

RUN mv -f /tmp/sources.list /etc/apt/sources.list && \
    apt update && \
    apt install -y pkg-config gcc make libxml2-dev openssl libssl-dev libsqlite3-dev zlib1g-dev libcurl4-gnutls-dev libpng-dev libwebp-dev libjpeg-dev libxpm-dev libfreetype6-dev libzip-dev libonig-dev libpcre3-dev supervisor

# PHP
RUN cd /tmp && tar -xf php-7.4.24.tar.gz && cd php-7.4.24 && ./configure --prefix=/usr/local/php  \
        --with-config-file-path=/usr/local/php/etc \
        --with-pdo-mysql \
        --with-openssl \
        --with-curl \
        --with-jpeg \
        --with-xpm \
        --with-webp \
        --with-freetype \
        --with-zlib \
        --with-zip=/usr/local/libzip \
        --enable-gd \
        --enable-fpm \
        --enable-bcmath \
        --enable-mbstring \
        && make && make install


RUN ln -s /usr/local/php/bin/php /usr/bin/php && \
    ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx && \
    cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf

# NGINX
RUN cd /tmp && tar -xf tengine-2.3.3.tar.gz && cd tengine-2.3.3 && ./configure --prefix=/usr/local/nginx \
        --with-http_stub_status_module \
        --with-http_ssl_module \
        --with-http_v2_module \
        --with-http_gzip_static_module \
        --with-http_sub_module \
        --with-stream \
        --with-stream_ssl_module \
        && make && make install

RUN mkdir -p /usr/local/nginx/conf/vhost && \
    mkdir -p /usr/local/nginx/conf/ssl && \
    mkdir -p /var/www && \
    mkdir -p /var/logs && \
    mkdir -p /etc/nginx/ssl && \
    openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048


RUN rm -rf /tmp/* && \
    useradd -s /sbin/nologin -M www

EXPOSE 443
