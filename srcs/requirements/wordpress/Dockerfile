FROM debian:bookworm

RUN apt-get update -y && apt-get install -y curl php php8.2-fpm php8.2-mysql

COPY ./tools/wordpress.sh /

RUN chmod +x wordpress.sh

EXPOSE 9000

ENTRYPOINT ["./wordpress.sh"]