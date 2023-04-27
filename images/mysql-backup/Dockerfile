FROM centos:7

COPY files/qshell /tmp/
COPY files/mysqldump /tmp/
COPY files/CentOS7-Base-163.repo /tmp/
COPY cmd/backup.sh /tmp/
COPY cmd/init.sh /tmp/

#RUN mv -f /tmp/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo && \
#    yum makecache && \
#    yum -y install epel-release && \
#    yum -y install crontabs
RUN yum -y install crontabs

# 安装qshell
RUN mv /tmp/qshell /usr/bin/qshell && chmod +x /usr/bin/qshell && \
    mv /tmp/mysqldump /usr/bin/mysqldump && chmod +x /usr/bin/mysqldump && \
    mv /tmp/backup.sh /usr/bin/backup.sh && chmod +x /usr/bin/backup.sh && \
    mv /tmp/init.sh /usr/bin/init.sh && chmod +x /usr/bin/init.sh && \
    mkdir -p /var/backup/ && chmod -R 777 /var/backup/ && \
    rm -rf /tmp/*

CMD ["/usr/bin/init.sh"]
