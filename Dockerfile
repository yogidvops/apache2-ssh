## Pull base image.
#FROM ubuntu:18.04
#
#MAINTAINER yogi
#
#FROM ubuntu
#USER root
#RUN apt-get update
#RUN apt-get install -y openssh-server
#RUN echo root:craterzone@123 | chpasswd
#RUN ssh-keygen -A
#CMD service ssh start
#
#EXPOSE 22 3306


FROM ubuntu:18.04
RUN apt-get update

RUN apt-get install -y openssh-server apache2 supervisor nginx

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

RUN echo 'root:root' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

#RUN sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf 
#RUN apt-get clean && \
    #rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80 443
CMD ["/usr/bin/supervisord"]
                              