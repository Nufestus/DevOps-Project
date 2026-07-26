FROM debian:bookworm

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./tools .

RUN chmod +x ./mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./mariadb.sh"]