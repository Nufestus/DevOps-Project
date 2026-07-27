FROM debian:bookworm

RUN apt-get update -y && apt-get install mariadb-server mariadb-client -y

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh .

RUN chmod +x mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./mariadb.sh"]