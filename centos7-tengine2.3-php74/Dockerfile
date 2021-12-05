FROM centos:7

COPY files/CentOS7-Base-163.repo /tmp/
COPY files/tengine-2.3.3.tar.gz /tmp/
COPY files/php-7.4.24.tar.gz /tmp/
COPY files/oniguruma-6.8.2-1.el7.x86_64.rpm /tmp/
COPY files/oniguruma-devel-6.8.2-1.el7.x86_64.rpm /tmp/

RUN mv -f /tmp/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo && \
    yum makecache && \
    yum -y install epel-release && \
    yum -y install gcc libxml2-devel sqlite-devel openssl-devel make supervisor && \
    cd /tmp && yum -y install *.x86_64.rpm && \

    cd /tmp && tar -xf php-7.4.24.tar.gz && cd php-7.4.24 && ./configure --prefix=/usr/local/php  \
        --with-config-file-path=/usr/local/php/etc \
        --with-pdo-mysql \
        --with-openssl \
        --enable-fpm \
        --enable-bcmath \
        --enable-mbstring \
        && make && make install && \

    cd /tmp && tar -xf tengine-2.3.3.tar.gz && cd tengine-2.3.3 && ./configure && make && make install

COPY conf/daemon.ini /etc/supervisord.d
COPY conf/php.ini /usr/local/php/etc/php.ini
COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY start.sh /

RUN ln -s /usr/local/php/bin/php /usr/bin/php && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    mkdir -p /usr/local/nginx/conf/vhost && mkdir -p /usr/local/nginx/conf/ssl && \
    useradd -s /sbin/nologin -M www && \
    rm -rf /tmp/* && yum clean all && \
    chmod +x start.sh

CMD ["./start.sh"]

EXPOSE 80 443
