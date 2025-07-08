FROM debian:latest

RUN apt update && apt upgrade -y && \
        apt install mariadb-server -y

RUN mkdir /run/mysqld

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY init.sql /etc/mysql/init.sql

CMD ["mysqld"]