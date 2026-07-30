FROM debian:bookworm

RUN apt-get update -y \
    && apt-get install nginx openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=aammisse.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./tools/nginx.sh .

RUN chmod +x nginx.sh

ENTRYPOINT ["./nginx.sh"]