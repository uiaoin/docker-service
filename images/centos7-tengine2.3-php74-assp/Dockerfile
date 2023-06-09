FROM centos:7

COPY files/CentOS7-Base-163.repo /tmp/
COPY files/tengine-2.3.3.tar.gz /tmp/
COPY files/php-7.4.24.tar.gz /tmp/
COPY files/oniguruma-6.8.2-1.el7.x86_64.rpm /tmp/
COPY files/libzip-1.8.0.tar.gz /tmp/
COPY files/cmake-3.16.6.tar.gz /tmp/
COPY files/oniguruma-devel-6.8.2-1.el7.x86_64.rpm /tmp/

RUN mv -f /tmp/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo && \
    yum makecache && \
    yum -y install epel-release && \
    yum -y install gcc gcc-c++ libxml2-devel sqlite-devel openssl openssl-devel curl-devel make supervisor libpng-devel libwebp-devel libjpeg-devel libXpm-devel freetype-devel && \
    cd /tmp && yum -y install *.x86_64.rpm

RUN cd /tmp && tar -xf cmake-3.16.6.tar.gz && cd cmake-3.16.6 && ./configure && make && make install
RUN cd /tmp && tar -xf libzip-1.8.0.tar.gz && cd libzip-1.8.0 && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make && make install

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

COPY files/wkhtmltox-0.12.6-1.centos7.x86_64.rpm /tmp/
RUN cd /tmp && yum -y install wkhtmltox-0.12.6-1.centos7.x86_64.rpm

RUN rm -rf /tmp/* && \
    yum clean all && \
    useradd -s /sbin/nologin -M www

# PHP扩展
COPY files/php-exts/* /usr/local/php/lib/php/extensions/no-debug-non-zts-20190902/

EXPOSE 443
